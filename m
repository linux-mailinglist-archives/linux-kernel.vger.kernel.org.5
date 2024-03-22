Return-Path: <linux-kernel+bounces-110936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7578865F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC98286395
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F57D8C15;
	Fri, 22 Mar 2024 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLovmRxD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA51A38FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084836; cv=none; b=PF94zDSISB4H5LDDxvvF+Shrh1ZzQ2lUy+JxatV/E64BxwYBPgh1h3iz1h6I/ATnYekXGWmQKS8EOnSFRJUK9nsEVW5r+jCqhvBNtEYB+BuQIVm11yZ5kjsT3AubSrpaLyeWDTAMdVgUpIY19AaHDXX7wILhXXmJdFL0Mvl92ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084836; c=relaxed/simple;
	bh=wkY3XvA11A+L3pQyNlA/k6s9pQsd08SfFaSttqTgBUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFHt9o+1mQSUEphLVcKaxCh+XAn4crwk2OqwUn43d00IIXTqG6s8WX65g6CrQyD2wQjv2b9OcTPS/9FaCCoykJhCSIMR+zxDZysUf5yA1N2gihsR69bVV749iohQ3H39uoj7g+KZf6BoMK/udvPt9pFcmOpzkjvib+3Upy6Dg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLovmRxD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPWt/vpen20Uq0Su+r5r4SqWWuc1vun1fgMIbeuBdwM=;
	b=aLovmRxDhZLT2EsIjp2Bj6rgix+wr4TuaofIIuh1eSPY1rGsu+nxVfB3e3TP4U/iU5WYbJ
	oB9D0Y9Q/atxlcKJcihcNogojna0mf5bN1T83D5ktXz7blolB4ioGoZJyOJ1R33ZC1evuw
	y9iaZzGnTnIzahlw62T0DuzdWD59y88=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-PgW4q8yvOeaNFANrd3M0LQ-1; Fri, 22 Mar 2024 01:20:30 -0400
X-MC-Unique: PgW4q8yvOeaNFANrd3M0LQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366b311d172so5190955ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084829; x=1711689629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPWt/vpen20Uq0Su+r5r4SqWWuc1vun1fgMIbeuBdwM=;
        b=g9mbiqL5QQrrcC+JyZ1v/PezURCIi5K1Vr+CD6N8AA29Vna0qlMN3KA0mvXFrUGak9
         ZoYDNt3o9mojRq+QENKnXzLACSzqwi/YwiSilymGbzwnLmxmbzyzdM/XvHonVJZgNS3P
         rYUumKaDelnUHkQfSpHjsZS874sURML728YemzTLo5F9JQUYd25G76nEfW7RId+9gGig
         8Rcs0i9akTb6qnveEkUy3H9sE5TsRXThosKgd5G9TN+K1wkfc5OFw1ASDDVnXR79DwEo
         CAjaGtxxnwFx0IbOPIb086AUjJFsiQDTEUMBSq3F/5xpbMc4TyC4j1d1DgMN+87WZPwH
         rchg==
X-Forwarded-Encrypted: i=1; AJvYcCXkV6Gx/MtTiHPMHus9qKr4Wvx32tgCvoFa5vmEQwtUfxXyjyDH0479NDl6421mrrfds2g73BuVx7K+0gmhSE7vJ5MqOmbWfV8m1lZA
X-Gm-Message-State: AOJu0YyfzIR2wLTl85VPlvR2Jpx2OPjIbdVPxefj+82XbhOZt/pQYeqI
	tjNmkjZIRDuI/86ukEYRZImtF53Xr6EB3NKryJVriZIW+5kYYRPGOO9Y9bVwJMH5QFoGpbkfsx0
	bi32e2YzXCMrz7Tf784puoP2UdnX7fewgtRraEYEfVW9x801AYLtdTlsX0+ikkVg2Tjei6jMyfL
	/MKNyuQsmeedARBlP9ksnVanj2JX3d1BM1yvDH
X-Received: by 2002:a92:ca06:0:b0:365:2bd4:2f74 with SMTP id j6-20020a92ca06000000b003652bd42f74mr1414328ils.0.1711084829660;
        Thu, 21 Mar 2024 22:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcqpN7yjbXB0akaKxrIaGNwP9eSMrNe1nhA0u4mzAyyJPP5E6Gj96qz1F7MFLE+aoAY3qt4Hni+gmE6ZFGN44=
X-Received: by 2002:a92:ca06:0:b0:365:2bd4:2f74 with SMTP id
 j6-20020a92ca06000000b003652bd42f74mr1414309ils.0.1711084829375; Thu, 21 Mar
 2024 22:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com>
 <ZfwMribQCTKWSO9l@dwarf.suse.cz> <CALu+AoT2jYfVTFpVvUJv5T+OdSAQzYw0kn74EighK5-4A3O16w@mail.gmail.com>
In-Reply-To: <CALu+AoT2jYfVTFpVvUJv5T+OdSAQzYw0kn74EighK5-4A3O16w@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Mar 2024 13:20:40 +0800
Message-ID: <CALu+AoT4BBFRw7P4gYWBq1PK=Qe2iR=d5YLUY_JyY2CU3SMrYg@mail.gmail.com>
Subject: Re: [PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
To: Jiri Bohac <jbohac@suse.cz>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	"Huang, Kai" <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

> > Your tree is missing this recent commit:
> > 7fd817c906503b6813ea3b41f5fdf4192449a707 ("x86/e820: Don't
> > reserve SETUP_RNG_SEED in e820").
> >
> > Wouldn't this fix [/paper over] your problem as well? I.e., isn't
> > SETUP_RNG_SEED the setup_data item that's causing your problem?
>
> Thanks for catching this, I will rebase and repost.
>
> But it does not "fix" the problem as my problem is related to the
> other setup_data
> range, I think it is SETUP_PCI (not 100% sure, but it is certainly not RNG_SEED)
>

The webmail reply broke the lines randomly, sorry for that.  I have
resent a rebased version.  And I also confirmed that in my case it was
SETUP_PCI caused the issue.   Note, this SETUP_PCI is from previous
physical bootup, the old kernel reserved it in kexec e820, it is not
the RNG_SEED which was passed in by kexec.  I believe the RND_SEED
region could cause issues only on the 3rd+ boot with a kernel without
the commit you mentioned.

It is a little tricky, I suppose not obvious to understand..

Thanks
Dave


