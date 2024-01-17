Return-Path: <linux-kernel+bounces-29446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA91830E62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8631C23E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BA125568;
	Wed, 17 Jan 2024 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sc+t+Qz+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89657250ED
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705525761; cv=none; b=SLTFCUM2IEFkv1bfJ9aDepIm3RVQOlGisLhasJ8nADHNEQstf92RF5l7eWkZUGzTHeTQ3HgFaF5+1ISYaCcFdE+VNk0z3OVLo1gUortT5HRtCSAGueaiwMxg4jiaIJ1lbw/xbXyGguFaNM8I0kLIENMTEr8yqDgON3zPB5JEE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705525761; c=relaxed/simple;
	bh=yiczJz5xo+gXi22FZY/cUNQzQjX9NFJDBZPspOkYXH0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hydaaLqmMy71NEJg9BxZRqHnwHc3q9OOEkiE7GKGuJnc8EmgtG1XWofsnVAEN4XgA8t5FjeBoEpaslIvc45WBQJKG7vea1SV5QCNfpUBrHjp1yrA4ZoOCp9IBALZedEyg1ejZE69FnupA9Fhhcaq5ypyDb5yt7+vJ7rPEdjfIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sc+t+Qz+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2ac304e526so1147553166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705525755; x=1706130555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6IFwG5b0R45jQy9tX/g5mkmRxt1SXH4oxO4wTmDPoQ=;
        b=Sc+t+Qz+TuqYbt6vDTDQ4WVXw4hs8FbVn9CuVICDAeSDg328oE0R/AozIyAUUxwUM/
         w4j3tJ9Y17RhUWaw6mEnS9mNDmYVrH4w4hQTPWkx1JtrBtvOFbahyvvsSuhsAnd9SJvU
         6UsR6B6cdOtrog9o9Us1VMa30xLQjd6ExQMneEeMqZRh1r0trVGTkzjcJdadT+sg4Ch6
         fHE2wqa5uQ5dDBcN5F7h1UDfYnrT7kZswpy8YSohq7ZH2WB7B6sIl3k493kyarfaeunk
         J+i1efIhSClniv89gMCu+x7ZbECkVczqZs54dTdWSBoQATPNh1qUkMJUv7Jw6jwyDQ1+
         clSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705525755; x=1706130555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6IFwG5b0R45jQy9tX/g5mkmRxt1SXH4oxO4wTmDPoQ=;
        b=V2GPlRMCCA28mXwvIxtRCJ777xjYfRq1W80hD8TibKzB1YbLAhS5jWnn9BLSL0YrMp
         myfjSoQVrL1WG8zzXTofb+XZPh2PN9aWNH1TZlsGl0Or3EQyzmvbqVK3ZWuwZRJF/+w7
         BJvt69H/WaRvkE3UCL3T+t8wHrg9GtiB94/tPnCOmU4PQTmR0K4f9SfUTFwUQhDMbYyK
         junFf1K5/J1hsKlH/bHG4UHtvTKTyD8MgX0yEJUwyrenx3/MEudoUETrpfBY9Ca+wGbN
         OfPsU7biLsJC1E1gCkZR4GPXbs3Pv9Ih5Y9FoxLOM/mAdLPzRAuqvmoryvHzGj7WxUmc
         QO9w==
X-Gm-Message-State: AOJu0YyxvCBliqqg9KqFn37PFugx/JSTuo4dAM++LxHwGJwukJy19OPT
	9zi5Yvj2LKs8Dlpq3ZBCGAq6EWiyFzKonKhdnuRe4Ca2novKmA==
X-Google-Smtp-Source: AGHT+IGDPHBPAM4q/KJXQev8stoy4X4hPad/fntquzFLGj7qrXFzP1rQLoWdZ+dumTkd2iS1oMJ/YxSLaGiJrXMhNdc=
X-Received: by 2002:a17:906:4744:b0:a2b:6db2:b8da with SMTP id
 j4-20020a170906474400b00a2b6db2b8damr4809932ejs.32.1705525754821; Wed, 17 Jan
 2024 13:09:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701540918.git.lduncan@suse.com> <dc0006176e90cf3fb90e5b1c1917b54fe07c91cd.1701540918.git.lduncan@suse.com>
 <ZXoOtgVZW_QpkU11@rhel-developer-toolbox-latest> <CAPj3X_W5kOEOapG3F8NETBRzBmrQ1Lfudy7QGmCLXPT3UwUrkw@mail.gmail.com>
 <ZXtlxzVtY3M_WrQ2@rhel-developer-toolbox-latest>
In-Reply-To: <ZXtlxzVtY3M_WrQ2@rhel-developer-toolbox-latest>
From: Lee Duncan <lduncan@suse.com>
Date: Wed, 17 Jan 2024 13:09:03 -0800
Message-ID: <CAPj3X_VvpuDQGHt2xtBOJB2RNGvFfxQiX0GH0My19G3OP+76QQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: target: iscsi: handle SCSI immediate commands
To: Chris Leech <cleech@redhat.com>
Cc: target-devel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dbond@suse.com, hare@suse.de, 
	michael.christie@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the delay in the reply, but over the
time to address Chris' two questions about this patch set. See below.

On Thu, Dec 14, 2023 at 12:30=E2=80=AFPM Chris Leech <cleech@redhat.com> wr=
ote:
>
> On Wed, Dec 13, 2023 at 05:24:54PM -0800, Lee Duncan wrote:
> > >
> > > > @@ -1255,14 +1248,15 @@ int iscsit_process_scsi_cmd(struct iscsit_c=
onn *conn, struct iscsit_cmd *cmd,
> > > >       /*
> > > >        * Check the CmdSN against ExpCmdSN/MaxCmdSN here if
> > > >        * the Immediate Bit is not set, and no Immediate
> > > > -      * Data is attached.
> > > > +      * Data is attached. Also skip the check if this is
> > > > +      * an immediate command.
> > >
> > > This comment addition seems redundant, isn't that what the
> > > "Immediate Bit is not set" already means?
> >
> > The spec is confusing with respect to this. The "Immediate Bit" means
> > an immediate command. These commands are done "now", not queued, and
> > they do not increment the expected sequence number.
> >
> > Immediate data is different, and unfortunately named IMHO. It's when a
> > PDU supplies the data for the SCSI command in the current PDU instead
> > of the next PDU.
>
> I understand the protocol, just trying to make sense of the
> implementation and what the existing comment meant. And the existing
> comment already has two conditions in it, even if the code doesn't.
>
> I think I understand now why this is delaying CmdSN validation when
> there is immediate data, until after the DataCRC can be checked.
>
> This comment in iscsit_get_immediate_data, where the delayed processing
> occurs, also seems to read that "Immediate Bit" is in reference to an
> immediate command.
>
>   * A PDU/CmdSN carrying Immediate Data passed
>   * DataCRC, check against ExpCmdSN/MaxCmdSN if
>   * Immediate Bit is not set.
>
> but neither of these locations (before these changes) that mention the
> "Immediate Bit" in the comments actually check for cmd->immediate_cmd.
>

I talked to Chris a bit about this offline, for clarification. I believe I
understand his concern, and rather than try to assert the patch is
ok by inspection, I decided to just test it.

Turns out that normal PDU traffic for lots of writes generally
includes "immediate data", and so it was easy to test this.

Testing showed that Immediate Data still works correctly,
in SCSI Write PDUs. Test was:
* connect to an iSCSI target
* Write a bunch of data
* read back the data
* disconnect from target and compare data

In addition, I captured and analyzed the SCSI/iSCSI tcpdump trace,
and immediate data was present, as expected.

One co-worker ran a similar test (just the SCSI/iSCSI trace part),
and found the same results.

> > > >        *
> > > >        * A PDU/CmdSN carrying Immediate Data can only
> > > >        * be processed after the DataCRC has passed.
> > > >        * If the DataCRC fails, the CmdSN MUST NOT
> > > >        * be acknowledged. (See below)
> > > >        */
> > > > -     if (!cmd->immediate_data) {
> > > > +     if (!cmd->immediate_data && !cmd->immediate_cmd) {
> > > >               cmdsn_ret =3D iscsit_sequence_cmd(conn, cmd,
> > > >                                       (unsigned char *)hdr, hdr->cm=
dsn);
> > > >               if (cmdsn_ret =3D=3D CMDSN_ERROR_CANNOT_RECOVER)
> > >
> > > Are you sure this needs to be checking both conditions here?  I'm
> > > struggling to understand why CmdSN checking would be bypassed for
> > > immediate data.  Is this a longstanding bug where the condition shoul=
d
> > > have been on immediate_cmd (and only immediate_cmd) instead?
> >
> > The immediate data check was there already, and there haven't been any
> > bugs I know of, so I assumed that part of the code was ok.
> >
> > >
> > > Or is this because of the handling the immediate data with DataCRC ca=
se
> > > mentioned?  I do see iscsit_sequence_cmd also being called in
> > > iscsit_get_immediate_data.
> >
> > I will check that but I suspect you are correct.
>
> Is it correct to skip all of iscsit_sequence_cmd for an immediate
> command here? You are already skipping iscsit_check_received_cmdsn
> inside iscsit_sequence_cmd in this patch. If cmd->immediate_cmd is set,
> where does iscsit_execute_cmd now get called from?

I looked at the code and the SPEC in more detail, and I believe the answer
is "yes", it is correct.

That function checks the current PDU's sequence number with
the following tests (and side effects), but not in this order:
* check that seq# is not larger than maximum
* check that seq# is not larger than expected
* check that seq# is not smaller than expected
* else the seq# is correct, so *SIDE* *EFFECT* increment the
                                               expected seq# for next PDU

It turns out that the SPEC allow the sequence number to be
out of range for immediate commands! So none of the checks
in iscsit_sequence_check_received_cmndsn() are valid for
immediate commands, as far as I can see.

>
> - Chris Leech
>

