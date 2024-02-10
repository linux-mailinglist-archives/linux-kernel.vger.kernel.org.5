Return-Path: <linux-kernel+bounces-60165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2418500F2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74E01F23A25
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9E1FD7;
	Sat, 10 Feb 2024 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9aVra4Q"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F86366
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707523355; cv=none; b=Ekyw9bA/MtDjJnuin4YFqLcIfTM1Wz2LoRtCI2JsDEl+9nYHv6GAevY3iubXdvwoaTmvrgxdSJ3Vsau7e2UnaOGm774BhywZd9bYrCy5kMyZBUUGywd27TetzfR5rIJiWYa5dVcgqkVbr9wKnFn5YrTaJ5392ikS9BlWNiBSYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707523355; c=relaxed/simple;
	bh=CiYWolk/vfX9z7/VvG4atCCtboOPv2bLFylPm6ehqnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHJ1uOfiXfe6lJnFMWBJxQ9ejvyPBegpBaJNw7KBbbo1xetCIFgjuB2h4Kng5MrL94za9qCeN0FZ3xSN34VDH2u3sMkVBwrSWLrcB5auGXhOOSMBKTxEBHFwyUQXJ3uFZ4clnpk/dB/qitjt7J/X079i8fyMVnubske/tG7usbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j9aVra4Q; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1023394a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707523353; x=1708128153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwiU/EL7x+TTCvwcK9PAOCc3lVIdELnMki1lstqoaI0=;
        b=j9aVra4QuPmtlVnQ1bsXYiDpfx2xntJ25IpljOa9nYwzZ1OLwqh2VkGg6S+WtSo0ke
         4D0SkA1bQ9usubawTm3Qd7cHaCvhPfvINg2dRSIyoCdtc8BI+1Eny8hGiDDOXD/ft4nY
         ufki2Gc4HThHT+yt/D580RxOiXTmFhOs9peYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707523353; x=1708128153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwiU/EL7x+TTCvwcK9PAOCc3lVIdELnMki1lstqoaI0=;
        b=P+xkLjwO/MC4dRztYCD3pK4ckz9z8/K+QTGCk+6h7PgWVXwvvpJ8z2wnBRDzvMCvZz
         pgq9TNzZe0K21glDdJbWODHS2CrSu37LEpv06Dxy4xoFifnbRB3yyn7jKeDXjZpUju1+
         R140sxxP/n2tZ/uhDmg/BCCQUUvoaTaxAP1eSNMC0SUR3x2Kd77WgNbT6PW8TKqO+KWA
         nlkK4cdoQ/z3bGTIeUVLYBdE2OPQoKZ8Y0NV5pejEHaetmpdXzNXwf7bw2aFVWLiLpSA
         wvV4F0Aj61IK0insCZRvsKbS1SPVjRIjJhSMj886tpH0dxt+H7/3eOcIF7SatOpv1aWs
         vvCw==
X-Gm-Message-State: AOJu0Yx3liwCBPjRthHO8hpZvc8mQ5RHOKe7tvS44V5/DByH6G+LZd9z
	gxCNJ7zhuuhBtseAxdWLDyOOx68Txem7zhJOKmBO4CEuIFsMaByhLujWW/ofMg==
X-Google-Smtp-Source: AGHT+IFYt9zQ6iV466dF02tv7d/5akGcb4/zwQYblm52fMJEQ8VRuQ1opyseKQa0f1ioxqEbLHJgrw==
X-Received: by 2002:a17:90a:a38b:b0:297:1927:71ed with SMTP id x11-20020a17090aa38b00b00297192771edmr10592pjp.6.1707523353243;
        Fri, 09 Feb 2024 16:02:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFbTmUwkFJK2FXfwij4l3oqX2vdOFdIrxdxPQbee24Y8MsU6BwVA83QmTvNq8fxVGZOikcPzS7vPRlKHHAmCz2iTf23aiFuspJ5Dzp8wY3Z9HYhPmyLNvTHgy/LLM8dMiI8xej0B1Lo9e7t2PdTy8Y4KVQzajsVm2K3l/3EKq7V9lR1wlTvIVMoEIZdFYmLk0XRx5nmrThIkBAY9JbhIFbJD2qBvO8P3bzJNC7kw4PQbHtIGQ10UGcI4mj45wub2QsrEMa0wBCehbFNqjn1icU/REEVwuJ0QCXzkyTYDdADaBDIjgQ3aIbQZmP9Tpy88ng
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pf17-20020a17090b1d9100b00297166eec71sm263907pjb.29.2024.02.09.16.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:02:32 -0800 (PST)
Date: Fri, 9 Feb 2024 16:02:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cifs: Convert struct fealist away from 1-element array
Message-ID: <202402091559.52D7C2AC@keescook>
References: <20230215000832.never.591-kees@kernel.org>
 <qjyfz2xftsbch6aozgplxyjfyqnuhn7j44udrucls4pqa5ey35@adxvvrdtagqf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qjyfz2xftsbch6aozgplxyjfyqnuhn7j44udrucls4pqa5ey35@adxvvrdtagqf>

On Sat, Feb 10, 2024 at 01:13:06AM +0300, Vitaly Chikunov wrote:
> Kees,
> 
> On Tue, Feb 14, 2023 at 04:08:39PM -0800, Kees Cook wrote:
> > The kernel is globally removing the ambiguous 0-length and 1-element
> > arrays in favor of flexible arrays, so that we can gain both compile-time
> > and run-time array bounds checking[1].
> > 
> > While struct fealist is defined as a "fake" flexible array (via a
> > 1-element array), it is only used for examination of the first array
> > element. Walking the list is performed separately, so there is no reason
> > to treat the "list" member of struct fealist as anything other than a
> > single entry. Adjust the struct and code to match.
> > 
> > Additionally, struct fea uses the "name" member either as a dynamic
> > string, or is manually calculated from the start of the struct. Redefine
> > the member as a flexible array.
> > 
> > No machine code output differences are produced after these changes.
> > 
> > [1] For lots of details, see both:
> >     https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> >     https://people.kernel.org/kees/bounded-flexible-arrays-in-c
> > 
> > Cc: Steve French <sfrench@samba.org>
> > Cc: Paulo Alcantara <pc@cjr.nz>
> > Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> > Cc: Shyam Prasad N <sprasad@microsoft.com>
> > Cc: Tom Talpey <tom@talpey.com>
> > Cc: linux-cifs@vger.kernel.org
> > Cc: samba-technical@lists.samba.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  fs/cifs/cifspdu.h |  4 ++--
> >  fs/cifs/cifssmb.c | 16 ++++++++--------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
> > index 623caece2b10..add73be4902c 100644
> > --- a/fs/cifs/cifspdu.h
> > +++ b/fs/cifs/cifspdu.h
> > @@ -2583,7 +2583,7 @@ struct fea {
> >  	unsigned char EA_flags;
> >  	__u8 name_len;
> >  	__le16 value_len;
> > -	char name[1];
> > +	char name[];
> >  	/* optionally followed by value */
> >  } __attribute__((packed));
> >  /* flags for _FEA.fEA */
> > @@ -2591,7 +2591,7 @@ struct fea {
> >  
> >  struct fealist {
> >  	__le32 list_len;
> > -	struct fea list[1];
> > +	struct fea list;
> >  } __attribute__((packed));
> >  
> >  /* used to hold an arbitrary blob of data */
> > diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> > index 60dd4e37030a..7c587157d030 100644
> > --- a/fs/cifs/cifssmb.c
> > +++ b/fs/cifs/cifssmb.c
> > @@ -5787,7 +5787,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
> >  
> >  	/* account for ea list len */
> >  	list_len -= 4;
> > -	temp_fea = ea_response_data->list;
> > +	temp_fea = &ea_response_data->list;
> >  	temp_ptr = (char *)temp_fea;
> >  	while (list_len > 0) {
> >  		unsigned int name_len;
> > @@ -5902,7 +5902,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
> >  	else
> >  		name_len = strnlen(ea_name, 255);
> >  
> > -	count = sizeof(*parm_data) + ea_value_len + name_len;
> > +	count = sizeof(*parm_data) + 1 + ea_value_len + name_len;
> >  	pSMB->MaxParameterCount = cpu_to_le16(2);
> >  	/* BB find max SMB PDU from sess */
> >  	pSMB->MaxDataCount = cpu_to_le16(1000);
> > @@ -5926,14 +5926,14 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
> >  	byte_count = 3 /* pad */  + params + count;
> >  	pSMB->DataCount = cpu_to_le16(count);
> >  	parm_data->list_len = cpu_to_le32(count);
> > -	parm_data->list[0].EA_flags = 0;
> > +	parm_data->list.EA_flags = 0;
> >  	/* we checked above that name len is less than 255 */
> > -	parm_data->list[0].name_len = (__u8)name_len;
> > +	parm_data->list.name_len = (__u8)name_len;
> >  	/* EA names are always ASCII */
> >  	if (ea_name)
> > -		strncpy(parm_data->list[0].name, ea_name, name_len);
> > -	parm_data->list[0].name[name_len] = 0;
> > -	parm_data->list[0].value_len = cpu_to_le16(ea_value_len);
> > +		strncpy(parm_data->list.name, ea_name, name_len);
> 
> Could non-applying this patch cause false-positive fortify_panic?
> We got a bug report from user of 6.1.73:
> 
>    Jan 24 15:15:20 kalt2test.dpt.local kernel: detected buffer overflow in strncpy

Yes, this seems likely. I would backport this change.

>    Jan 24 15:15:20 kalt2test.dpt.local kernel: ------------[ cut here ]------------
>    Jan 24 15:15:20 kalt2test.dpt.local kernel: kernel BUG at lib/string_helpers.c:1027!
>    ...
>    Jan 24 15:15:20 kalt2test.dpt.local kernel: Call Trace:
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  CIFSSMBSetEA.cold+0xc/0x18 [cifs]
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  cifs_xattr_set+0x596/0x690 [cifs]
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  __vfs_removexattr+0x52/0x70
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  __vfs_removexattr_locked+0xbc/0x150
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  vfs_removexattr+0x56/0x100
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  removexattr+0x58/0x90
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  __ia32_sys_fremovexattr+0x80/0xa0
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  int80_emulation+0xa9/0x110
>    Jan 24 15:15:20 kalt2test.dpt.local kernel:  asm_int80_emulation+0x16/0x20

This appears to be a compat call?

-Kees

> 
> I don't find this patch appled to stable/linux-6.1.y.
> 
> Thanks,
> 
> ps. (Unfortunately `CIFSSMBSetEA+0xc` address is not resolvable to the
> actual line inside of CIFSSMBSetEA pointing just to the head of it.
> 
>    (gdb) l *CIFSSMBSetEA+0xc
>    0x6de3c is in CIFSSMBSetEA (fs/smb/client/cifssmb.c:5776).
>    5771    int
>    5772    CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
>    5773                 const char *fileName, const char *ea_name, const void *ea_value,
>    5774                 const __u16 ea_value_len, const struct nls_table *nls_codepage,
>    5775                 struct cifs_sb_info *cifs_sb)
>    5776    {
>    5777            struct smb_com_transaction2_spi_req *pSMB = NULL;
>    5778            struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
>    5779            struct fealist *parm_data;
>    5780            int name_len;
> 
> But there is only one strncpy there.
> 
> > +	parm_data->list.name[name_len] = '\0';
> > +	parm_data->list.value_len = cpu_to_le16(ea_value_len);
> >  	/* caller ensures that ea_value_len is less than 64K but
> >  	we need to ensure that it fits within the smb */
> >  
> > @@ -5941,7 +5941,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
> >  	     negotiated SMB buffer size BB */
> >  	/* if (ea_value_len > buffer_size - 512 (enough for header)) */
> >  	if (ea_value_len)
> > -		memcpy(parm_data->list[0].name+name_len+1,
> > +		memcpy(parm_data->list.name + name_len + 1,
> >  		       ea_value, ea_value_len);
> >  
> >  	pSMB->TotalDataCount = pSMB->DataCount;
> > -- 
> > 2.34.1
> > 

-- 
Kees Cook

