Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0BE7F261E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjKUHGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjKUHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:06:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C38C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:06:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899DFC433C7;
        Tue, 21 Nov 2023 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700550390;
        bh=U5lgYFwJwveZX6VvJjduX3a3pzJmocFwMI7ltZ6S+/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZgAfpbVELIbYq17PN8dBD+0bxFM89kOkTJqW+3cD/E8t4OLkYtT9mivstfh1CW63
         WH7KYghFNd2FEoxu4w8PJpX20RJSvEQOBNrHJy9ldnm1zqpCnTXPBT2FIIzNDqsF7R
         dAEsoiX5ibla+vDtvHQQOjmhQsaeBYD+rYOQh8E5pgYnWJRmX9A840NXgKXtpdJcPE
         DFBW5HULSIXq8C67XduWuGbKMRT7mQ7MLUn6nZVToCRbyg5cCbbSFBHXq2j6jLiP3e
         vhJTUH1orFVUvdU/F2lIrmhcFmzSPbKmTnVdWjzONdmuwPOpbuIR8CARgIFToosYv6
         pzS/rLTwM1I0A==
From:   Saeed Mahameed <saeed@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH V3 4/5] misc: mlx5ctl: Add command rpc ioctl
Date:   Mon, 20 Nov 2023 23:06:18 -0800
Message-ID: <20231121070619.9836-5-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121070619.9836-1-saeed@kernel.org>
References: <20231121070619.9836-1-saeed@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

Add new IOCTL to allow user space to send device debug rpcs and
attach the user's uctx UID to each rpc.

In the mlx5 architecture the FW RPC commands are of the format of
inbox and outbox buffers. The inbox buffer contains the command
rpc layout as described in the ConnectX Programmers Reference Manual
(PRM) document and as defined in include/linux/mlx5/mlx5_ifc.h.

On success the user outbox buffer will be filled with the device's rpc
response.

For example to query device capabilities:
a user fills out an inbox buffer with the inbox layout:
   struct mlx5_ifc_query_hca_cap_in_bits
and expects an outbox buffer with the layout:
   struct mlx5_ifc_cmd_hca_cap_bits

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/misc/mlx5ctl/main.c | 95 +++++++++++++++++++++++++++++++++++++
 include/uapi/misc/mlx5ctl.h | 13 +++++
 2 files changed, 108 insertions(+)

diff --git a/drivers/misc/mlx5ctl/main.c b/drivers/misc/mlx5ctl/main.c
index 6a98b40e4300..e7776ea4bfca 100644
--- a/drivers/misc/mlx5ctl/main.c
+++ b/drivers/misc/mlx5ctl/main.c
@@ -232,6 +232,97 @@ static int mlx5ctl_info_ioctl(struct file *file,
 	return err;
 }
 
+struct mlx5_ifc_mbox_in_hdr_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_mbox_out_hdr_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+static int mlx5ctl_cmdrpc_ioctl(struct file *file,
+				struct mlx5ctl_cmdrpc __user *arg,
+				size_t usize)
+{
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+	struct mlx5ctl_cmdrpc *rpc = NULL;
+	void *in = NULL, *out = NULL;
+	size_t ksize = 0;
+	int err;
+
+	ksize = max(sizeof(struct mlx5ctl_cmdrpc), usize);
+	rpc = kzalloc(ksize, GFP_KERNEL_ACCOUNT);
+	if (!rpc)
+		return -ENOMEM;
+
+	err = copy_from_user(rpc, arg, usize);
+	if (err)
+		goto out;
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdrpc: rpc->inlen %d rpc->outlen %d\n",
+		    mfd->uctx_uid, rpc->inlen, rpc->outlen);
+
+	if (rpc->inlen < MLX5_ST_SZ_BYTES(mbox_in_hdr) ||
+	    rpc->outlen < MLX5_ST_SZ_BYTES(mbox_out_hdr) ||
+	    rpc->inlen > MLX5CTL_MAX_RPC_SIZE ||
+	    rpc->outlen > MLX5CTL_MAX_RPC_SIZE) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (rpc->flags) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	in = memdup_user(u64_to_user_ptr(rpc->in), rpc->inlen);
+	if (IS_ERR(in)) {
+		err = PTR_ERR(in);
+		goto out;
+	}
+
+	out = kvzalloc(rpc->outlen, GFP_KERNEL_ACCOUNT);
+	if (!out) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x inlen %d outlen %d\n",
+		    mfd->uctx_uid,
+		    MLX5_GET(mbox_in_hdr, in, opcode), rpc->inlen, rpc->outlen);
+
+	MLX5_SET(mbox_in_hdr, in, uid, mfd->uctx_uid);
+	err = mlx5_cmd_do(mcdev->mdev, in, rpc->inlen, out, rpc->outlen);
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x retval %d\n",
+		    mfd->uctx_uid,
+		    MLX5_GET(mbox_in_hdr, in, opcode), err);
+
+	/* -EREMOTEIO means outbox is valid, but out.status is not */
+	if (!err || err == -EREMOTEIO) {
+		err = 0;
+		if (copy_to_user(u64_to_user_ptr(rpc->out), out, rpc->outlen))
+			err = -EFAULT;
+	}
+
+out:
+	kvfree(out);
+	kfree(in);
+	kfree(rpc);
+	return err;
+}
+
 static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct mlx5ctl_fd *mfd = file->private_data;
@@ -257,6 +348,10 @@ static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		err = mlx5ctl_info_ioctl(file, argp, size);
 		break;
 
+	case MLX5CTL_IOCTL_CMDRPC:
+		err = mlx5ctl_cmdrpc_ioctl(file, argp, size);
+		break;
+
 	default:
 		mlx5ctl_dbg(mcdev, "Unknown ioctl %x\n", cmd);
 		err = -ENOIOCTLCMD;
diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
index 37153cc0fc6e..3277eaf78a37 100644
--- a/include/uapi/misc/mlx5ctl.h
+++ b/include/uapi/misc/mlx5ctl.h
@@ -16,9 +16,22 @@ struct mlx5ctl_info {
 	__u32 reserved2;
 };
 
+struct mlx5ctl_cmdrpc {
+	__aligned_u64 in; /* RPC inbox buffer user address */
+	__aligned_u64 out; /* RPC outbox buffer user address */
+	__u32 inlen; /* inbox buffer length */
+	__u32 outlen; /* outbox buffer length */
+	__aligned_u64 flags;
+};
+
+#define MLX5CTL_MAX_RPC_SIZE 8192
+
 #define MLX5CTL_IOCTL_MAGIC 0x5c
 
 #define MLX5CTL_IOCTL_INFO \
 	_IOR(MLX5CTL_IOCTL_MAGIC, 0x0, struct mlx5ctl_info)
 
+#define MLX5CTL_IOCTL_CMDRPC \
+	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x1, struct mlx5ctl_cmdrpc)
+
 #endif /* __MLX5CTL_IOCTL_H__ */
-- 
2.42.0

