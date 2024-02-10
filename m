Return-Path: <linux-kernel+bounces-60186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B585011C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131DD28098E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC39110A;
	Sat, 10 Feb 2024 00:28:36 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF57365;
	Sat, 10 Feb 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524915; cv=none; b=pyzv/Oo+nYBN/9HS2X3R8LOIfP2QP5V7jtwt0O6ldhmpRMUFeG6pAogwHDhkMIsLojgAAVCWABdxzBdBHMQUfjyP6d1Wlkl0ZEXgZD5zFPCXh6/QZetW3uVe+NUve2GZFauWDOP2zJdXnqGJUlClb8UJPP28MqkJR26N/mpbZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524915; c=relaxed/simple;
	bh=1aldXA7qX7BJQwCosF1vpPxnrS0eikCsVyMupUViDPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNORlMFcyUM15B+xHcnru20/GEb28qbU1ZJKF7sSJuapbl+etjLsPqCxksUE7H+OBVRxk1+fjwyKf+VOtr0vUcQwEQ5HZiQ0yqIOhU/h+ymMaaPHDM7yMlU95LmAPXjs0dNpQVwASFYtGs6aMlbk1LiBWa0Igzl0nnbwrB3mfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id D2BE472C8F5;
	Sat, 10 Feb 2024 03:28:30 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
	by imap.altlinux.org (Postfix) with ESMTPSA id C35DA36D0246;
	Sat, 10 Feb 2024 03:28:30 +0300 (MSK)
Date: Sat, 10 Feb 2024 03:28:30 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Kees Cook <keescook@chromium.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cifs: Convert struct fealist away from 1-element array
Message-ID: <20240210002830.g3orqr3d2cwcmadz@altlinux.org>
References: <20230215000832.never.591-kees@kernel.org>
 <qjyfz2xftsbch6aozgplxyjfyqnuhn7j44udrucls4pqa5ey35@adxvvrdtagqf>
 <202402091559.52D7C2AC@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <202402091559.52D7C2AC@keescook>

Kees,

On Fri, Feb 09, 2024 at 04:02:32PM -0800, Kees Cook wrote:
> On Sat, Feb 10, 2024 at 01:13:06AM +0300, Vitaly Chikunov wrote:
> > On Tue, Feb 14, 2023 at 04:08:39PM -0800, Kees Cook wrote:
> > > The kernel is globally removing the ambiguous 0-length and 1-element
> > > arrays in favor of flexible arrays, so that we can gain both compile-time
> > > and run-time array bounds checking[1].
> > > 
> > > While struct fealist is defined as a "fake" flexible array (via a
> > > 1-element array), it is only used for examination of the first array
> > > element. Walking the list is performed separately, so there is no reason
> > > to treat the "list" member of struct fealist as anything other than a
> > > single entry. Adjust the struct and code to match.
> > > 
> > > Additionally, struct fea uses the "name" member either as a dynamic
> > > string, or is manually calculated from the start of the struct. Redefine
> > > the member as a flexible array.
> > > 
> > > No machine code output differences are produced after these changes.
> > > 
> > > [1] For lots of details, see both:
> > >     https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> > >     https://people.kernel.org/kees/bounded-flexible-arrays-in-c
> > > 
> > > Cc: Steve French <sfrench@samba.org>
> > > Cc: Paulo Alcantara <pc@cjr.nz>
> > > Cc: Ronnie Sahlberg <lsahlber@redhat.com>
> > > Cc: Shyam Prasad N <sprasad@microsoft.com>
> > > Cc: Tom Talpey <tom@talpey.com>
> > > Cc: linux-cifs@vger.kernel.org
> > > Cc: samba-technical@lists.samba.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  fs/cifs/cifspdu.h |  4 ++--
> > >  fs/cifs/cifssmb.c | 16 ++++++++--------
> > >  2 files changed, 10 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
> > > index 623caece2b10..add73be4902c 100644
> > > --- a/fs/cifs/cifspdu.h
> > > +++ b/fs/cifs/cifspdu.h
> > > @@ -2583,7 +2583,7 @@ struct fea {
> > >  	unsigned char EA_flags;
> > >  	__u8 name_len;
> > >  	__le16 value_len;
> > > -	char name[1];
> > > +	char name[];
> > >  	/* optionally followed by value */
> > >  } __attribute__((packed));
> > >  /* flags for _FEA.fEA */
> > > @@ -2591,7 +2591,7 @@ struct fea {
> > >  
> > >  struct fealist {
> > >  	__le32 list_len;
> > > -	struct fea list[1];
> > > +	struct fea list;
> > >  } __attribute__((packed));
> > >  
> > >  /* used to hold an arbitrary blob of data */
> > > diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> > > index 60dd4e37030a..7c587157d030 100644
> > > --- a/fs/cifs/cifssmb.c
> > > +++ b/fs/cifs/cifssmb.c
> > > @@ -5787,7 +5787,7 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
> > >  
> > >  	/* account for ea list len */
> > >  	list_len -= 4;
> > > -	temp_fea = ea_response_data->list;
> > > +	temp_fea = &ea_response_data->list;
> > >  	temp_ptr = (char *)temp_fea;
> > >  	while (list_len > 0) {
> > >  		unsigned int name_len;
> > > @@ -5902,7 +5902,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
> > >  	else
> > >  		name_len = strnlen(ea_name, 255);
> > >  
> > > -	count = sizeof(*parm_data) + ea_value_len + name_len;
> > > +	count = sizeof(*parm_data) + 1 + ea_value_len + name_len;
> > >  	pSMB->MaxParameterCount = cpu_to_le16(2);
> > >  	/* BB find max SMB PDU from sess */
> > >  	pSMB->MaxDataCount = cpu_to_le16(1000);
> > > @@ -5926,14 +5926,14 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
> > >  	byte_count = 3 /* pad */  + params + count;
> > >  	pSMB->DataCount = cpu_to_le16(count);
> > >  	parm_data->list_len = cpu_to_le32(count);
> > > -	parm_data->list[0].EA_flags = 0;
> > > +	parm_data->list.EA_flags = 0;
> > >  	/* we checked above that name len is less than 255 */
> > > -	parm_data->list[0].name_len = (__u8)name_len;
> > > +	parm_data->list.name_len = (__u8)name_len;
> > >  	/* EA names are always ASCII */
> > >  	if (ea_name)
> > > -		strncpy(parm_data->list[0].name, ea_name, name_len);
> > > -	parm_data->list[0].name[name_len] = 0;
> > > -	parm_data->list[0].value_len = cpu_to_le16(ea_value_len);
> > > +		strncpy(parm_data->list.name, ea_name, name_len);
> > 
> > Could non-applying this patch cause false-positive fortify_panic?
> > We got a bug report from user of 6.1.73:
> > 
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel: detected buffer overflow in strncpy
> 
> Yes, this seems likely. I would backport this change.
> 
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel: ------------[ cut here ]------------
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel: kernel BUG at lib/string_helpers.c:1027!
> >    ...
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel: Call Trace:
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  CIFSSMBSetEA.cold+0xc/0x18 [cifs]
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  cifs_xattr_set+0x596/0x690 [cifs]
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  __vfs_removexattr+0x52/0x70
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  __vfs_removexattr_locked+0xbc/0x150
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  vfs_removexattr+0x56/0x100
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  removexattr+0x58/0x90
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  __ia32_sys_fremovexattr+0x80/0xa0
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  int80_emulation+0xa9/0x110
> >    Jan 24 15:15:20 kalt2test.dpt.local kernel:  asm_int80_emulation+0x16/0x20
> 
> This appears to be a compat call?

Likely. This is caused through Wine.

Thanks,

> 
> -Kees
> 
> > 
> > I don't find this patch appled to stable/linux-6.1.y.
> > 
> > Thanks,
> > 
> > ps. (Unfortunately `CIFSSMBSetEA+0xc` address is not resolvable to the
> > actual line inside of CIFSSMBSetEA pointing just to the head of it.
> > 
> >    (gdb) l *CIFSSMBSetEA+0xc
> >    0x6de3c is in CIFSSMBSetEA (fs/smb/client/cifssmb.c:5776).
> >    5771    int
> >    5772    CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
> >    5773                 const char *fileName, const char *ea_name, const void *ea_value,
> >    5774                 const __u16 ea_value_len, const struct nls_table *nls_codepage,
> >    5775                 struct cifs_sb_info *cifs_sb)
> >    5776    {
> >    5777            struct smb_com_transaction2_spi_req *pSMB = NULL;
> >    5778            struct smb_com_transaction2_spi_rsp *pSMBr = NULL;
> >    5779            struct fealist *parm_data;
> >    5780            int name_len;
> > 
> > But there is only one strncpy there.
> > 
> > > +	parm_data->list.name[name_len] = '\0';
> > > +	parm_data->list.value_len = cpu_to_le16(ea_value_len);
> > >  	/* caller ensures that ea_value_len is less than 64K but
> > >  	we need to ensure that it fits within the smb */
> > >  
> > > @@ -5941,7 +5941,7 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
> > >  	     negotiated SMB buffer size BB */
> > >  	/* if (ea_value_len > buffer_size - 512 (enough for header)) */
> > >  	if (ea_value_len)
> > > -		memcpy(parm_data->list[0].name+name_len+1,
> > > +		memcpy(parm_data->list.name + name_len + 1,
> > >  		       ea_value, ea_value_len);
> > >  
> > >  	pSMB->TotalDataCount = pSMB->DataCount;
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> Kees Cook

