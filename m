Return-Path: <linux-kernel+bounces-155839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDAD8AF7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C282281E52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CBF14264F;
	Tue, 23 Apr 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6/7T36j"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B795B1E3;
	Tue, 23 Apr 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713903341; cv=none; b=P1II89f0cCljQUKzRZrkoiEtUUyPzmiAW8iFkrfJ259kcATWBY50YY0MhBJERwZRr8V2N8T8ge16mDfY3gDm2odOIdfuh5x0YE0/tIyPV5SaxCIGtx40uuBWz7d0BdHCi2oo/oGkmuLMuu4imn2PvzaLedTBsgUaetNJwBy76Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713903341; c=relaxed/simple;
	bh=TD3mjfHYij/IIDnbcbjkSnV0l5txDJydu/EgURwaCgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwxnBSGQX1T63D5D5Ib1gBRb2GKN/jNtUNFjpSIv/+qMZsQonRT3tHRrjZImzWFoMkhfgYWFYNxDLrP8MMnRdPcTBd3gbajXqYPQZ4/8Vm/3l4EABMHMrRWIe9WgW9B/XcqJdM/53FCfPaGjS6uPM9lt/Sy9SmVL+5cQUXsFRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6/7T36j; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51bab51e963so1323159e87.1;
        Tue, 23 Apr 2024 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713903337; x=1714508137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGLZnDWFDCrusOH5UcKXNKUGAQq9CjXmcb6zRjXi6LY=;
        b=C6/7T36jkHOJCkEkl+ADEcTRxHhBfvM/kcQiquP99zXfRlSI3QL5p5FjjqwJM/muwg
         GlvvFrvxOGxvi4z6pXuUvLpYsYCV+yNlu9i07yhgv0WTlUHhGhjnIkhe62bFpm/ZRRbu
         Lz2JygFQhnnFG+1scksMz8+NjGDOIdw/EGL2lrORNZ0qIKPu4HwWlyf21GpD2xy/iT4I
         dhsYRADZSjYgcc6Qf1wovPds+LDgMx2xJ8L4omIWWFdkTL9BTFPhOcNadUSYqzjelCfa
         NNctPTDbZsEwdxw1GwnKdLllULt+8gFtxzFcnz+zs99txT/RJ5G748W5fUV1saJzv669
         QK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713903337; x=1714508137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGLZnDWFDCrusOH5UcKXNKUGAQq9CjXmcb6zRjXi6LY=;
        b=gCZ7q/vDYqCCObZizpe12YKDva3slMnDMrp3riM3SwgIFPdPj10irKrkoKfuz0R2Vj
         n3SoLxbxjwazgYCr79jvEB3RmhRWUX9WPjnVcQULMmSNtpuCW4KmmfqYouA/bVcyGrG6
         MEIGjcd1eayuAU/kcJID57XPmjtr5K7dm4lc+VRGN6Yl/isFcQ7N7QPSjfhd//MVJoEp
         dUk/dIzO/PUqi8idTi0ZkVOJEcJvq/2xeJfXhowZLIhnDuLT+sPhLiWg6yD1IlwAQ2KX
         YjKwSCgyBzkkDPKlTQVNsBhAKd3Jn4Qhi6jurmfKfv35LUn9XCXKvnBZsqqjH3Rm1nrf
         wkAA==
X-Forwarded-Encrypted: i=1; AJvYcCWYjLNPhiYcG4tovsO/hGwK/tbTjC0sAs9Nusg7zlSif7p+FoPjp014Wb997UWADaQde0fnbJZ1b+w+Qc3YZ2xFm2G0X2kkqX9JOuEe1sDy17aA2k0DLjHsaQJlp+4GwzkhkP42TmKRzkLgqWGtpoVOTDG19Q3sppzTMS2WW2dkoct3fngchcbEmw==
X-Gm-Message-State: AOJu0Yy1ujHYgAVbSvRfDB0+pwC3BQkG5Jrph5g7KXVQ1WXgPvU0d1Rd
	eDlaT3kEZGM+ErLJjNOg6BKR1qDdKz4g/D7rz6DJniimk8GpSIp0ka6ggm+1iWhNq1cKd27vcnI
	LfLfo5OZTSkOGsCMQ2E/GF9ktUK4lhdgX
X-Google-Smtp-Source: AGHT+IEyhJecIivbLUIDM3IUmHGP5A5wQhqjg/Q1m0UANUeHn8MZITQtt0La4viLjyuveSssLkaDXNbAtLAFKTYjmqU=
X-Received: by 2002:ac2:5105:0:b0:517:8594:2c00 with SMTP id
 q5-20020ac25105000000b0051785942c00mr367332lfb.22.1713903336634; Tue, 23 Apr
 2024 13:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhgDTj1nwLEtSd9h@neat> <1166494b-3e34-4919-9998-141540a948b3@embeddedor.com>
In-Reply-To: <1166494b-3e34-4919-9998-141540a948b3@embeddedor.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 23 Apr 2024 15:15:24 -0500
Message-ID: <CAH2r5msZaV1kHqQw8Sb_3wQfGBj4aU+tSCR5E0YJ8fCH6ODB4Q@mail.gmail.com>
Subject: Re: [PATCH][next] smb: smb2pdu.h: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks reasonably safe (running the usual regression tests on it now).

Reminds me though that we have to be careful (e.g. the recent fix for
regression caused by cleanup).

Thoughts about whether should be sent in rc6 or wait till 6.10?  51
warnings does sound
distracting though so might be worth going in sooner rather than later.

commit 0268a7cc7fdc47d90b6c18859de7718d5059f6f1
Author: Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri Apr 19 23:46:34 2024 +0900

    ksmbd: common: use struct_group_attr instead of struct_group for
network_open_info

    4byte padding cause the connection issue with the applications of MacOS=
.
    smb2_close response size increases by 4 bytes by padding, And the smb
    client of MacOS check it and stop the connection. This patch use
    struct_group_attr instead of struct_group for network_open_info to use
     __packed to avoid padding.


On Tue, Apr 23, 2024 at 1:58=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Friendly ping: who can take this, please?
>
> Thanks
> --
> Gustavo
>
> On 11/04/24 09:35, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> > ready to enable it globally.
> >
> > So, in order to avoid ending up with a flexible-array member in the
> > middle of multiple other structs, we use the `__struct_group()` helper
> > to separate the flexible array from the rest of the members in the
> > flexible structure, and use the tagged `struct create_context_hdr`
> > instead of `struct create_context`.
> >
> > So, with these changes, fix 51 of the following warnings[1]:
> >
> > fs/smb/client/../common/smb2pdu.h:1225:31: warning: structure containin=
g a flexible array member is not at the end of another structure [-Wflex-ar=
ray-member-not-at-end]
> >
> > Link: https://gist.github.com/GustavoARSilva/772526a39be3dd4db39e71497f=
0a9893 [1]
> > Link: https://github.com/KSPP/linux/issues/202
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   fs/smb/client/smb2pdu.h | 12 ++++++------
> >   fs/smb/common/smb2pdu.h | 33 ++++++++++++++++++---------------
> >   fs/smb/server/smb2pdu.h | 18 +++++++++---------
> >   3 files changed, 33 insertions(+), 30 deletions(-)
> >
> > diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
> > index c72a3b2886b7..1a02bd9e0c00 100644
> > --- a/fs/smb/client/smb2pdu.h
> > +++ b/fs/smb/client/smb2pdu.h
> > @@ -145,7 +145,7 @@ struct durable_context_v2 {
> >   } __packed;
> >
> >   struct create_durable_v2 {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       struct durable_context_v2 dcontext;
> >   } __packed;
> > @@ -167,7 +167,7 @@ struct durable_reconnect_context_v2_rsp {
> >   } __packed;
> >
> >   struct create_durable_handle_reconnect_v2 {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       struct durable_reconnect_context_v2 dcontext;
> >       __u8   Pad[4];
> > @@ -175,7 +175,7 @@ struct create_durable_handle_reconnect_v2 {
> >
> >   /* See MS-SMB2 2.2.13.2.5 */
> >   struct crt_twarp_ctxt {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8    Name[8];
> >       __le64  Timestamp;
> >
> > @@ -183,12 +183,12 @@ struct crt_twarp_ctxt {
> >
> >   /* See MS-SMB2 2.2.13.2.9 */
> >   struct crt_query_id_ctxt {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8    Name[8];
> >   } __packed;
> >
> >   struct crt_sd_ctxt {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8    Name[8];
> >       struct smb3_sd sd;
> >   } __packed;
> > @@ -415,7 +415,7 @@ struct smb2_posix_info_parsed {
> >   };
> >
> >   struct smb2_create_ea_ctx {
> > -     struct create_context ctx;
> > +     struct create_context_hdr ctx;
> >       __u8 name[8];
> >       struct smb2_file_full_ea_info ea;
> >   } __packed;
> > diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
> > index 1b594307c9d5..eab9d49c63ba 100644
> > --- a/fs/smb/common/smb2pdu.h
> > +++ b/fs/smb/common/smb2pdu.h
> > @@ -1171,12 +1171,15 @@ struct smb2_server_client_notification {
> >   #define SMB2_CREATE_FLAG_REPARSEPOINT 0x01
> >
> >   struct create_context {
> > -     __le32 Next;
> > -     __le16 NameOffset;
> > -     __le16 NameLength;
> > -     __le16 Reserved;
> > -     __le16 DataOffset;
> > -     __le32 DataLength;
> > +     /* New members must be added within the struct_group() macro belo=
w. */
> > +     __struct_group(create_context_hdr, hdr, __packed,
> > +             __le32 Next;
> > +             __le16 NameOffset;
> > +             __le16 NameLength;
> > +             __le16 Reserved;
> > +             __le16 DataOffset;
> > +             __le32 DataLength;
> > +     );
> >       __u8 Buffer[];
> >   } __packed;
> >
> > @@ -1222,7 +1225,7 @@ struct smb2_create_rsp {
> >   } __packed;
> >
> >   struct create_posix {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8    Name[16];
> >       __le32  Mode;
> >       __u32   Reserved;
> > @@ -1230,7 +1233,7 @@ struct create_posix {
> >
> >   /* See MS-SMB2 2.2.13.2.3 and MS-SMB2 2.2.13.2.4 */
> >   struct create_durable {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       union {
> >               __u8  Reserved[16];
> > @@ -1243,14 +1246,14 @@ struct create_durable {
> >
> >   /* See MS-SMB2 2.2.13.2.5 */
> >   struct create_mxac_req {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       __le64 Timestamp;
> >   } __packed;
> >
> >   /* See MS-SMB2 2.2.14.2.5 */
> >   struct create_mxac_rsp {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       __le32 QueryStatus;
> >       __le32 MaximalAccess;
> > @@ -1286,13 +1289,13 @@ struct lease_context_v2 {
> >   } __packed;
> >
> >   struct create_lease {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       struct lease_context lcontext;
> >   } __packed;
> >
> >   struct create_lease_v2 {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       struct lease_context_v2 lcontext;
> >       __u8   Pad[4];
> > @@ -1300,7 +1303,7 @@ struct create_lease_v2 {
> >
> >   /* See MS-SMB2 2.2.14.2.9 */
> >   struct create_disk_id_rsp {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       __le64 DiskFileId;
> >       __le64 VolumeId;
> > @@ -1309,7 +1312,7 @@ struct create_disk_id_rsp {
> >
> >   /* See MS-SMB2 2.2.13.2.13 */
> >   struct create_app_inst_id {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8 Name[16];
> >       __le32 StructureSize; /* Must be 20 */
> >       __u16 Reserved;
> > @@ -1318,7 +1321,7 @@ struct create_app_inst_id {
> >
> >   /* See MS-SMB2 2.2.13.2.15 */
> >   struct create_app_inst_id_vers {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8 Name[16];
> >       __le32 StructureSize; /* Must be 24 */
> >       __u16 Reserved;
> > diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
> > index bd1d2a0e9203..643f5e1cfe35 100644
> > --- a/fs/smb/server/smb2pdu.h
> > +++ b/fs/smb/server/smb2pdu.h
> > @@ -64,7 +64,7 @@ struct preauth_integrity_info {
> >   #define SMB2_SESSION_TIMEOUT                (10 * HZ)
> >
> >   struct create_durable_req_v2 {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       __le32 Timeout;
> >       __le32 Flags;
> > @@ -73,7 +73,7 @@ struct create_durable_req_v2 {
> >   } __packed;
> >
> >   struct create_durable_reconn_req {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       union {
> >               __u8  Reserved[16];
> > @@ -85,7 +85,7 @@ struct create_durable_reconn_req {
> >   } __packed;
> >
> >   struct create_durable_reconn_v2_req {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       struct {
> >               __u64 PersistentFileId;
> > @@ -96,13 +96,13 @@ struct create_durable_reconn_v2_req {
> >   } __packed;
> >
> >   struct create_alloc_size_req {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       __le64 AllocationSize;
> >   } __packed;
> >
> >   struct create_durable_rsp {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       union {
> >               __u8  Reserved[8];
> > @@ -114,7 +114,7 @@ struct create_durable_rsp {
> >   /* Flags */
> >   #define SMB2_DHANDLE_FLAG_PERSISTENT        0x00000002
> >   struct create_durable_v2_rsp {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       __le32 Timeout;
> >       __le32 Flags;
> > @@ -122,7 +122,7 @@ struct create_durable_v2_rsp {
> >
> >   /* equivalent of the contents of SMB3.1.1 POSIX open context response=
 */
> >   struct create_posix_rsp {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8    Name[16];
> >       __le32 nlink;
> >       __le32 reparse_tag;
> > @@ -381,13 +381,13 @@ struct smb2_ea_info {
> >   } __packed; /* level 15 Query */
> >
> >   struct create_ea_buf_req {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       struct smb2_ea_info ea;
> >   } __packed;
> >
> >   struct create_sd_buf_req {
> > -     struct create_context ccontext;
> > +     struct create_context_hdr ccontext;
> >       __u8   Name[8];
> >       struct smb_ntsd ntsd;
> >   } __packed;
>


--
Thanks,

Steve

