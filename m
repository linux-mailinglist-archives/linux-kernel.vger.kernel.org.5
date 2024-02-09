Return-Path: <linux-kernel+bounces-59249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D14884F3D4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD61C2132B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190BA25630;
	Fri,  9 Feb 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXECrLG1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC821D549;
	Fri,  9 Feb 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475977; cv=none; b=J5YPNI3bx9MS38G3utwuWxWXyG5jZLSlt0jA7DmthshpPj43fR7gBVNIrNql//Iw79MzfPCOEHLkS2U1U+ZuNrr7ZuV5uoCGG2y9KzYjsVOzjiY3BfYRQ4ImnfQnxZ2ngzeJmZnnGzSb3CnirHDdoDag0iYsPfZEeep+MUwZx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475977; c=relaxed/simple;
	bh=6dwnkyROxGZ2SBXY1Zy0Ne8yjBZ4UXuUgvnfXsanGsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea3AmzFlrWIIab7lg3H0RTvHqgiMaa38Jw6UJZFsEK+ODsEH2PFvpJ41MfUfw6YwVU2f8UZBkklhKlCVeHdyDHCJvyuY/rCFphHx6KJxDVLHXwitZQUuYAv+nBgL67eBPE0mBMYldtFah7gz9isHjKHDG2RzFnHLHCEmjpnWino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXECrLG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639B6C433C7;
	Fri,  9 Feb 2024 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707475976;
	bh=6dwnkyROxGZ2SBXY1Zy0Ne8yjBZ4UXuUgvnfXsanGsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXECrLG1KqQf6D1VRtpPf0wmtjc9PzW9ElAmQMSqXLAzHQKbzULSUnUOE3Bby2xlp
	 GK7ieqInVtLdUUSYzlGAcRaW0rv6cfSTNYvOmKWKkk3lXyh8IF6+7uNzHyUdUcPj6t
	 NrxJJnPLsb66NeenDW6S2qSV0Klh/g4oECelQu6sXppSXmP8rS9g/2ErRO/+8IPFzF
	 LQCMwdSk4qJx/skt/SzOs/nexEbRBThp96JwWg4DAbDaf57O4lNB2Ryg1HNYrcKzAL
	 3P/2VVnO4+ivMyhapwruu/QIZR7iTGesCy5u4DjniEHH5m5l9yRYlgdoTr+0aCv7oF
	 AiBrIDrSfsCPQ==
Date: Fri, 9 Feb 2024 10:52:51 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: Re: [PATCH v5 09/12] cifs: Cut over to using netfslib
Message-ID: <20240209105251.GE1516992@kernel.org>
References: <20240205225726.3104808-1-dhowells@redhat.com>
 <20240205225726.3104808-10-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205225726.3104808-10-dhowells@redhat.com>

On Mon, Feb 05, 2024 at 10:57:21PM +0000, David Howells wrote:

..

> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 84e3675eb41e..b58fdee40755 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -4386,10 +4386,12 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
>  	req->Length = cpu_to_le32(io_parms->length);
>  	req->Offset = cpu_to_le64(io_parms->offset);
>  
> -	trace_smb3_read_enter(0 /* xid */,
> -			io_parms->persistent_fid,
> -			io_parms->tcon->tid, io_parms->tcon->ses->Suid,
> -			io_parms->offset, io_parms->length);
> +	trace_smb3_read_enter(rdata ? rdata->rreq->debug_id : 0,
> +			      rdata ? rdata->subreq.debug_index : 0,
> +			      rdata ? rdata->xid : 0,
> +			      io_parms->persistent_fid,
> +			      io_parms->tcon->tid, io_parms->tcon->ses->Suid,
> +			      io_parms->offset, io_parms->length);
>  #ifdef CONFIG_CIFS_SMB_DIRECT

Hi David,

above some care is taken to handle the case where rdata might be NULL.

However, the code below this hunk, other than being guarded by
smb3_use_rdma_offload(io_parms), uses rdata unconditionally.

Perhaps the guard makes this ok. But Smatch flags this inconsistency.
And I thought I should bring it to your attention.

For reference the code I am referring to looks like this:

#ifdef CONFIG_CIFS_SMB_DIRECT
	/*
	 * If we want to do a RDMA write, fill in and append
	 * smbd_buffer_descriptor_v1 to the end of read request
	 */
	if (smb3_use_rdma_offload(io_parms)) {
		struct smbd_buffer_descriptor_v1 *v1;
		bool need_invalidate = server->dialect == SMB30_PROT_ID;

		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->subreq.io_iter,
					     true, need_invalidate);
		if (!rdata->mr)
			return -EAGAIN;


..

