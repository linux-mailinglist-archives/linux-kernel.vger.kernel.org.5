Return-Path: <linux-kernel+bounces-56076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64384C5A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1321B287BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5B208B4;
	Wed,  7 Feb 2024 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0dpA67q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56C2031E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290908; cv=none; b=qHlgnq+1fnnDWrBF3TvS5w3LWSbAimeKPjLT1NndaXW6jm12hvYqgwURa/ST/M+Np1hY6A1agMz0piaAoND952UKK2ia70QhtHuI+GgEu7zqSexqmf0rIbscZk5j+ZvtBjN3tWdSuP4RWOHVx0U+SNIDAfgTpdZFXJ827DZInlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290908; c=relaxed/simple;
	bh=bWaLjtidBr05TM3D/n6lluQMqun8vTEheO+oRY9qZFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZB34D5fI4IlhBkFuyVnp/+CJb1fHRIsffPoNENGG0L7YGiyrQqRdT7ykQ18P4bapiRYZ47jybWUOdmKPpz9cTdIEmtYEd73MOWieRqo+0WAp/ACHE/hishgnXNuO7XUm6AFWS+jFRMWs+U/SVyQYL9b3gOqddzjEHvpqM2zi4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0dpA67q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A13C43394;
	Wed,  7 Feb 2024 07:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707290907;
	bh=bWaLjtidBr05TM3D/n6lluQMqun8vTEheO+oRY9qZFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0dpA67qPnQmmuH5cjhc5BndXI09AW43QOWyyduSQG5elWe3RG0Wmq2ycUfQh+qmE
	 8QlJsjkZSrNDFyszol3FV/sSxkwhOdQ1+zTbBYy/TLep+hgGpecQlYPorbKhcbez5M
	 RCbbnpTNpj9pmMHtS1oU91nFgpGSKv0eNqyUnufn/MOGbCDJnhOphOy6jOva/bkOJ+
	 jFzzP5ZHmhQqklhc+E0r28jFbopXqyK7CmJYfnGTkSlEvl2l8YO42TXJ77ovR/s4au
	 swyvN7C4avpqkiCBHd4dvAqPo8bnOBmj/+SctTwEbNtIhnl0VWK3QWXwGwZB8pAMp7
	 Wu7AcsINtBzTg==
From: Saeed Mahameed <saeed@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/5] misc: mlx5ctl: Add command rpc ioctl
Date: Tue,  6 Feb 2024 23:24:34 -0800
Message-ID: <20240207072435.14182-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207072435.14182-1-saeed@kernel.org>
References: <20240207072435.14182-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/misc/mlx5ctl/main.c | 98 +++++++++++++++++++++++++++++++++++++
 include/uapi/misc/mlx5ctl.h | 12 +++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/misc/mlx5ctl/main.c b/drivers/misc/mlx5ctl/main.c
index e4e70359dbe8..c02b80efffc1 100644
--- a/drivers/misc/mlx5ctl/main.c
+++ b/drivers/misc/mlx5ctl/main.c
@@ -245,6 +245,94 @@ static int mlx5ctl_info_ioctl(struct file *file,
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
+	size_t ksize = sizeof(struct mlx5ctl_cmdrpc);
+	struct mlx5ctl_fd *mfd = file->private_data;
+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
+	struct mlx5ctl_cmdrpc *rpc = NULL;
+	void *in = NULL, *out = NULL;
+	int err;
+
+	if (usize < ksize)
+		return -EINVAL;
+
+	rpc = kzalloc(ksize, GFP_KERNEL);
+	if (!rpc)
+		return -ENOMEM;
+
+	err = copy_from_user(rpc, arg, usize);
+	if (err)
+		goto out;
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdrpc: inlen %d outlen %d\n",
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
+	in = memdup_user(u64_to_user_ptr(rpc->in), rpc->inlen);
+	if (IS_ERR(in)) {
+		err = PTR_ERR(in);
+		goto out;
+	}
+
+	out = kvzalloc(rpc->outlen, GFP_KERNEL);
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
@@ -270,6 +358,10 @@ static long mlx5ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		err = mlx5ctl_info_ioctl(file, argp, size);
 		break;
 
+	case MLX5CTL_IOCTL_CMDRPC:
+		err = mlx5ctl_cmdrpc_ioctl(file, argp, size);
+		break;
+
 	default:
 		mlx5ctl_dbg(mcdev, "Unknown ioctl %x\n", cmd);
 		err = -ENOTTY;
@@ -328,6 +420,11 @@ static int mlx5ctl_probe(struct auxiliary_device *adev,
 		goto abort;
 	}
 
+	err = sysfs_create_link_nowarn(&mcdev->miscdev.this_device->kobj,
+				       &mdev->device->kobj, "mdev");
+	if (err)
+		mlx5ctl_dbg(mcdev, "mlx5ctl: failed to create sysfs link err %d\n", err);
+
 	mlx5ctl_dbg(mcdev, "probe mdev@%s %s\n",
 		    dev_driver_string(mdev->device),
 		    dev_name(mdev->device));
@@ -348,6 +445,7 @@ static void mlx5ctl_remove(struct auxiliary_device *adev)
 	struct mlx5_core_dev *mdev = mcdev->mdev;
 	struct mlx5ctl_fd *mfd, *n;
 
+	sysfs_remove_link(&mcdev->miscdev.this_device->kobj, "mdev");
 	misc_deregister(&mcdev->miscdev);
 	down_write(&mcdev->rw_lock);
 
diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
index 9be944128025..1e4622c5979f 100644
--- a/include/uapi/misc/mlx5ctl.h
+++ b/include/uapi/misc/mlx5ctl.h
@@ -12,9 +12,21 @@ struct mlx5ctl_info {
 	__u32 ucap; /* process user capability */
 };
 
+struct mlx5ctl_cmdrpc {
+	__aligned_u64 in; /* RPC inbox buffer user address */
+	__aligned_u64 out; /* RPC outbox buffer user address */
+	__u32 inlen; /* inbox buffer length */
+	__u32 outlen; /* outbox buffer length */
+};
+
+#define MLX5CTL_MAX_RPC_SIZE (512 * 512) /* max FW RPC buffer size 512 blocks of 512 bytes */
+
 #define MLX5CTL_IOCTL_MAGIC 0x5c
 
 #define MLX5CTL_IOCTL_INFO \
 	_IOR(MLX5CTL_IOCTL_MAGIC, 0x0, struct mlx5ctl_info)
 
+#define MLX5CTL_IOCTL_CMDRPC \
+	_IOWR(MLX5CTL_IOCTL_MAGIC, 0x1, struct mlx5ctl_cmdrpc)
+
 #endif /* __MLX5CTL_IOCTL_H__ */
-- 
2.43.0


