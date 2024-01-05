Return-Path: <linux-kernel+bounces-17891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B1782549F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9061BB22C01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483062D791;
	Fri,  5 Jan 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="r2qTnBRB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E82D781;
	Fri,  5 Jan 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=PiMVdce53Ufudq9W9yWmSnj7Yoq+fvtR1119t1CZpPI=; b=r2qTnBRB5DIJUJWgUPBK2ce91h
	dJxh9rtiy8G4k2vDEx+FzZP2IlDE65E7d7t1sjmaC89Kh7uyI9LkoMI6eJy57lCa8+zLm26izWOBK
	W3WB3o1U55DMaq6lXzfw1JrmhIwEL27A2UBch+5I4nT7NSvCyNkZOCqIyBSECfKkMWYotr7F/t+HS
	AZCE//dKeiM7MDy3XFSzBn2SD6SwB/24j71nBNE+RCVwdJkllEPgsGuT6JrKCXUfI6WeorILn4xbZ
	yu+jVQVUjIeEpgOf5xXKFew3PUV8KjujZdI/15elLdhEZbIU3sZtEYF2FW/nRnocM+QYUdiSW9E6L
	9OYYiCGg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1rLkJu-001i9w-DT; Fri, 05 Jan 2024 13:33:06 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5A7BBBE2DE0; Fri,  5 Jan 2024 14:33:05 +0100 (CET)
Date: Fri, 5 Jan 2024 14:33:05 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Ben Hutchings <benh@debian.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: Information on use-after-free in smb2_is_status_io_timeout()?
Message-ID: <ZZgFEX3QNWWj_VxA@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: carnil

Hi,

There is a Red Hat bugzilla report in
https://bugzilla.redhat.com/show_bug.cgi?id=2154178 about a
use-after-free in smb2_is_status_io_timeout() . While the commit noted
initially there seems not correct, Ben Hutchings raised a question on
more information in
https://bugzilla.redhat.com/show_bug.cgi?id=2154178#c24 .

(there is a CVE assigned for it, CVE-2023-1192)

To quote the initial message in RHBZ#2154178:

> A use after free flaw was found in smb2_is_status_io_timeout() in CIFS
> in the Linux Kernel. After CIFS transfers response data to system
> call, there is still a local variable points to the memory region, and
> if system call frees it faster than CIFS uses it, CIFS will access a
> free memory region leading to a denial of service.

Ben asked:

> smb2_is_status_io_timeout() is only ever called from cifs_demultiplex_thread().
> That happens after it conditionally decrypts the original receive buffer (buf) into
> one or more new buffers (bufs[...]), or otherwise sets bufs[0] = buf.  The
> decryption process looks like it can free the original buffer, resulting in the
> reported UAF.
> 
> If the error code is part of the encrypted payload, then I think the check for an
> I/O timeout should use bufs[0] like other code further down the function:
> 
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -1236,7 +1236,7 @@ cifs_demultiplex_thread(void *p)
>                 }
> 
>                 if (server->ops->is_status_io_timeout &&
> -                   server->ops->is_status_io_timeout(buf)) {
> +                   server->ops->is_status_io_timeout(bufs[0])) {
>                         num_io_timeout++;
>                         if (num_io_timeout > MAX_STATUS_IO_TIMEOUT) {
>                                 cifs_server_dbg(VFS,
> --- END ---
> 
> If the error code does not get encrypted, then the timeout check needs to be done
> further up the function.
> 
> Does anyone have a reproducer for this?

Does anyone knows more on this issue?

Regards,
Salvatore

