Return-Path: <linux-kernel+bounces-79357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7F862128
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662412864B5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1B8EDF;
	Sat, 24 Feb 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XG1gMhAu"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03313ECE
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734210; cv=none; b=b/vBq6PM8FeY9dd6p0nAkGhIH4am6GRoaxHaRoOxkMkuBqkJdDNQ7LnE8UKzjTh8eV1VrPMqy+s4xfLm30xjBB8pEsG9tUOd+U8lXWO5pwztamyfjMwYLJLCvwZNTBeUFW9qDQYA6jfY+aTwHDTcopGCmQxhvSuRbmPdT+YgUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734210; c=relaxed/simple;
	bh=/KBTgDtx9iqxLGOnVDV65i60I9gYZ01mwe9y6PSyVF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2upjgCmGvRPHJCCWy51dc2PUyBr7SOjAqExiFjgFrE5Gv79s18nncImcJBxOViwxQ0k5udT9DeL8E5zhBDPaIgI7g4a8jeYKkJSFwsSvFwNl/Ij/NlY5AGptCnzQFNmk6jtP9yhk21M9e4AbO7jf4K9P++4WFxhGrkPkvUa2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XG1gMhAu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e2e6bcc115so460871a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708734204; x=1709339004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDZ+jIfcZnSyT6ko3bZa/QkR2I1bAFTbjf79kFMZltI=;
        b=XG1gMhAuyDWgV1iYkFQIZpsfZlRhBuMO8IZkuTo7VNOb0hlE0Gs8AgE3RgyVlI24Ij
         eRjby26jB31axuAaOp0EqQFa14zjYjEx/RoFBL1I6f0s92EhW1VuHe5bnpCPxiO/rM43
         YyNMduUrQrX7wKXkPw0r6HwlxMIBDPp7FEAHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708734204; x=1709339004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDZ+jIfcZnSyT6ko3bZa/QkR2I1bAFTbjf79kFMZltI=;
        b=YxNFnbgyoyFYHGqn8IpnHeLdfH05NOTGl6EloVQ3zRmUQgduZbemr7QGkmAd2a1t2H
         4Tkwuslcz2e2eu1vGo0GMtYkRahNyhu2cqTLNOHqoDLyUE5dS6UaKt4vNO7Xz89PKvk9
         i1zHpXHECEM63LoAzBpog9ERgw/G7YKcWsCGO7ie9ElANKxwCxwHDfLnji8nm62HNMVZ
         G7mykV4uP2DJS28ZK9+VarIxfZTKmOMN5B1yMKo5nOZHzIG0xuy5fTtuVghPv/xJ6J+N
         mZdS2jNbwALAYRORZktFegYQO1q52Jyd7VPcoSFYAA7c8sAVkpW9VuCYmCeLp5rNfFsR
         c+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/bdOotDK3/vFXfExxxbZM58KvCsQyuw67PxXYyJ2+Tt90KzGhHuGXddoRiQgkkyA+rtyUzVk0vbqQl08tNLZSYWdF66R7e1GWXQDp
X-Gm-Message-State: AOJu0Yw0OSd7UApTnnNQpQa94vpyHx7LM+zl1DRjJBEtB/xEDTR9Z+6U
	fwGTgAZuikDRJU7lsQGXqE7sa6U3nDrD3rx1+jsq9z3C0M4PPtdio+NJ4R1e61VyRKu0H+CgpBM
	=
X-Google-Smtp-Source: AGHT+IGgLYDyRxzzGX2Ym3I1LfXv+ag2fv25ZMLSP8c/c3USRwTcmglDTsCYIbM5/n2QasSMK8oqfw==
X-Received: by 2002:a05:6830:1418:b0:6e4:7b54:966f with SMTP id v24-20020a056830141800b006e47b54966fmr1478582otp.18.1708734203786;
        Fri, 23 Feb 2024 16:23:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i12-20020a056a00004c00b006e4d42e218csm63131pfk.41.2024.02.23.16.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:23:23 -0800 (PST)
Date: Fri, 23 Feb 2024 16:23:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurav Kashyap <skashyap@marvell.com>,
	Javed Hasan <jhasan@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Don Brace <don.brace@microchip.com>,
	mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, netdev@vger.kernel.org,
	storagedev@microchip.com
Subject: Re: [PATCH 4/7] scsi: qla4xxx: replace deprecated strncpy with
 strscpy
Message-ID: <202402231613.F845617@keescook>
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
 <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-4-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-4-9cd3882f0700@google.com>

On Fri, Feb 23, 2024 at 10:23:09PM +0000, Justin Stitt wrote:
> Replace 3 instances of strncpy in ql4_mbx.c
> 
> No bugs exist in the current implementation as some care was taken to
> ensure the write length was decreased by one to leave some space for a
> NUL-byte. However, instead of using strncpy(dest, src, LEN-1) we can opt
> for strscpy(dest, src, sizeof(dest)) which will result in
> NUL-termination as well. It should be noted that the entire chap_table
> is zero-allocated so the NUL-padding provided by strncpy is not needed.
> 
> While here, I noticed that MIN_CHAP_SECRET_LEN was not used anywhere.
> Since strscpy gives us the number of bytes copied into the destination
> buffer (or an -E2BIG) we can check both for an error during copying and
> also for a non-length compliant secret. Add a new jump label so we can
> properly clean up our chap_table should we have to abort due to bad
> secret.
> 
> The third instance in this file involves some more peculiar handling of
> strings:
> |	uint32_t mbox_cmd[MBOX_REG_COUNT];
> |	...
> |	memset(&mbox_cmd, 0, sizeof(mbox_cmd));
> |	...
> |	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
> |	if (param == SET_DRVR_VERSION) {
> |		mbox_cmd[1] = SET_DRVR_VERSION;
> |		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
> |			MAX_DRVR_VER_LEN - 1);
> 
> mbox_cmd has a size of 8:
> |	#define MBOX_REG_COUNT 8
> ... and its type width is 4 bytes. Hence, we have 32 bytes to work with
> here. The first 4 bytes are used as a flag for the MBOX_CMD_SET_PARAM.
> The next 4 bytes are used for SET_DRVR_VERSION. We now have 32-8=24
> bytes remaining -- which thankfully is what MAX_DRVR_VER_LEN is equal to
> |	#define MAX_DRVR_VER_LEN                    24
> 
> ... and the thing we're copying into this pseudo-string buffer is
> |	#define QLA4XXX_DRIVER_VERSION        "5.04.00-k6"
> 
> ... which is great because its less than 24 bytes (therefore we aren't
> truncating the source).
> 
> All to say, there's no bug in the existing implementation (yay!) but we
> can clean the code up a bit by using strscpy().
> 
> In ql4_os.c, there aren't any strncpy() uses to replace but there are
> some existing strscpy() calls that could be made more idiomatic. Where
> possible, use strscpy(dest, src, sizeof(dest)). Note that
> chap_rec->password has a size of ISCSI_CHAP_AUTH_SECRET_MAX_LEN
> |	#define ISCSI_CHAP_AUTH_SECRET_MAX_LEN	256
> ... while the current strscpy usage uses QL4_CHAP_MAX_SECRET_LEN
> |	#define QL4_CHAP_MAX_SECRET_LEN 100
> ... however since chap_table->secret was set and bounded properly in its
> string assignment its probably safe here to switch over to sizeof().
> 
> |	struct iscsi_chap_rec {
> 	...
> |		char username[ISCSI_CHAP_AUTH_NAME_MAX_LEN];
> |		uint8_t password[ISCSI_CHAP_AUTH_SECRET_MAX_LEN];
> 	...
> |	};
> 
> |	strscpy(chap_rec->password, chap_table->secret,
> |		QL4_CHAP_MAX_SECRET_LEN);
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/scsi/qla4xxx/ql4_mbx.c | 17 ++++++++++++-----
>  drivers/scsi/qla4xxx/ql4_os.c  | 14 +++++++-------
>  2 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
> index 249f1d7021d4..75125d2021f5 100644
> --- a/drivers/scsi/qla4xxx/ql4_mbx.c
> +++ b/drivers/scsi/qla4xxx/ql4_mbx.c
> @@ -1641,6 +1641,7 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
>  	struct ql4_chap_table *chap_table;
>  	uint32_t chap_size = 0;
>  	dma_addr_t chap_dma;
> +	ssize_t secret_len;
>  
>  	chap_table = dma_pool_zalloc(ha->chap_dma_pool, GFP_KERNEL, &chap_dma);
>  	if (chap_table == NULL) {
> @@ -1652,9 +1653,13 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
>  		chap_table->flags |= BIT_6; /* peer */
>  	else
>  		chap_table->flags |= BIT_7; /* local */
> -	chap_table->secret_len = strlen(password);
> -	strncpy(chap_table->secret, password, MAX_CHAP_SECRET_LEN - 1);
> -	strncpy(chap_table->name, username, MAX_CHAP_NAME_LEN - 1);
> +
> +	secret_len = strscpy(chap_table->secret, password,
> +			     sizeof(chap_table->secret));
> +	if (secret_len < MIN_CHAP_SECRET_LEN)
> +		goto cleanup_chap_table;
> +	chap_table->secret_len = (uint8_t)secret_len;
> +	strscpy(chap_table->name, username, sizeof(chap_table->name));

I'm genuinely not sure what to do here, but I suspect your approach is
safest.

I can't see where chap_table->secret is getting set, but if it was
longer than 100 bytes, there was a bug here, as strncpy() would truncate
but chap_table->secret_len would continue to have the original length.
However, it looks like the buf_len passed to iscsi_set_param() is
ignored. O_o

>  	chap_table->cookie = cpu_to_le16(CHAP_VALID_COOKIE);
>  
>  	if (is_qla40XX(ha)) {
> @@ -1679,6 +1684,8 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
>  		memcpy((struct ql4_chap_table *)ha->chap_list + idx,
>  		       chap_table, sizeof(struct ql4_chap_table));
>  	}
> +
> +cleanup_chap_table:
>  	dma_pool_free(ha->chap_dma_pool, chap_table, chap_dma);
>  	if (rval != QLA_SUCCESS)
>  		ret =  -EINVAL;
> @@ -2281,8 +2288,8 @@ int qla4_8xxx_set_param(struct scsi_qla_host *ha, int param)
>  	mbox_cmd[0] = MBOX_CMD_SET_PARAM;
>  	if (param == SET_DRVR_VERSION) {
>  		mbox_cmd[1] = SET_DRVR_VERSION;
> -		strncpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
> -			MAX_DRVR_VER_LEN - 1);
> +		strscpy((char *)&mbox_cmd[2], QLA4XXX_DRIVER_VERSION,
> +			MAX_DRVR_VER_LEN);

As you mentioned in the commit log, this is a weird destination, but
is a legit calculation.

>  	} else {
>  		ql4_printk(KERN_ERR, ha, "%s: invalid parameter 0x%x\n",
>  			   __func__, param);
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 675332e49a7b..17cccd14765f 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -799,10 +799,10 @@ static int qla4xxx_get_chap_list(struct Scsi_Host *shost, uint16_t chap_tbl_idx,
>  
>  		chap_rec->chap_tbl_idx = i;
>  		strscpy(chap_rec->username, chap_table->name,
> -			ISCSI_CHAP_AUTH_NAME_MAX_LEN);
> -		strscpy(chap_rec->password, chap_table->secret,
> -			QL4_CHAP_MAX_SECRET_LEN);
> -		chap_rec->password_length = chap_table->secret_len;
> +			sizeof(chap_rec->username));
> +		chap_rec->password_length = strscpy(chap_rec->password,
> +						    chap_table->secret,
> +						    sizeof(chap_rec->password));
>  
>  		if (chap_table->flags & BIT_7) /* local */
>  			chap_rec->chap_type = CHAP_TYPE_OUT;
> @@ -6291,8 +6291,8 @@ static void qla4xxx_get_param_ddb(struct ddb_entry *ddb_entry,
>  
>  	tddb->tpgt = sess->tpgt;
>  	tddb->port = conn->persistent_port;
> -	strscpy(tddb->iscsi_name, sess->targetname, ISCSI_NAME_SIZE);
> -	strscpy(tddb->ip_addr, conn->persistent_address, DDB_IPADDR_LEN);
> +	strscpy(tddb->iscsi_name, sess->targetname, sizeof(tddb->iscsi_name));
> +	strscpy(tddb->ip_addr, conn->persistent_address, sizeof(tddb->ip_addr));
>  }
>  
>  static void qla4xxx_convert_param_ddb(struct dev_db_entry *fw_ddb_entry,
> @@ -7792,7 +7792,7 @@ static int qla4xxx_sysfs_ddb_logout(struct iscsi_bus_flash_session *fnode_sess,
>  	}
>  
>  	strscpy(flash_tddb->iscsi_name, fnode_sess->targetname,
> -		ISCSI_NAME_SIZE);
> +		sizeof(flash_tddb->iscsi_name));
>  
>  	if (!strncmp(fnode_sess->portal_type, PORTAL_TYPE_IPV6, 4))
>  		sprintf(flash_tddb->ip_addr, "%pI6", fnode_conn->ipaddress);
> 
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

