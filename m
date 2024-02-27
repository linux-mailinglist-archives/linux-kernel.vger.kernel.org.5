Return-Path: <linux-kernel+bounces-83894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4A869FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360471F2F83C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825251C5C;
	Tue, 27 Feb 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dO1IEkYn"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E14D107
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060650; cv=none; b=jJuMHtA6ePCLcGHdDu233KbGHRnhMOR1EG3+VtBcgFsgN/2Vgf9BDhxNKFoFxVX6enj6QGU1VS6nAuqKK1V8YZ3bxanfabatWapWiv3/WrfiqtxFezKG72MBBxzAtn5lV/hnBT08DzcPjmCLWx+U9GW7XCXutHe9XYDWH4luIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060650; c=relaxed/simple;
	bh=21TxnJJiVMUZ/n7IdqP9Jer8gcJ9D6Qk8IRk3fS3eUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX6rvDRvnBiMudnkda0ptNrMdU5MYZ6nM6bk6OVNjPeaTQbjMHjLoEMBhCKaoWOOr2QS4hzluxIoksjPdgsGvcJHqFqlVYVygtqahUlITPI799KhUrg0VrXwiqimVPqjPvK8oiOj0vV0TTq0HehVBji609ymE1gG+cF9h5dmw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dO1IEkYn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so802575ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709060647; x=1709665447; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OMAkp8kLDRBH6DaL/T38O2uylPO/mVKUbw4jqD28o5s=;
        b=dO1IEkYnHiIWW7sznF02s5eLEGKKPSviYTz6rIpH5a0qnWAaB7i6C9//Igqbo28MM0
         nWVXR2KtBYyvvv/oDjW9o7OKWUsFlUFhNgl0hWtWCKvWbrHBpchVPs2SEHqTZ9HT+Z0c
         VXsUXcBu43zXD5dG3/VTI4DAdFF+EbY5sqCvPJhQRTkhoRX6wVrg7ShBW0Ita/ZuQiEK
         Wf9qsZai+LOPiqEt4iIctq37npX8VG70mTkzKzt0VT9FcAOZxkYFJBhTV28Unr7/bWdH
         zFkyIr9Icx/RBUNMplQspVBuohka3eRCbJA5gdSoZgU548rEzK+aYlpynM8+y39ehGc9
         QrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060647; x=1709665447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMAkp8kLDRBH6DaL/T38O2uylPO/mVKUbw4jqD28o5s=;
        b=nwHbZ+Dw+FVp/yWiILWMf0ax6/eKXYc4fDIpTXlZm4PzpkJVTuaDZaXOWyAyfCU9x/
         Oih5r2/cmGoH2VyVEMn9AUVNv24z9FipU/h8PO0qODotuIDmuzFx3m/wm0BirbzsKFP+
         wOOEeb9pCSrwOp1fQSTtWKirxQnsLEvkLQP0mgjo3W0lv2kDGFyYgtrRvcFw4jsOnO01
         sgz0oCZJssaq/FTAfsvENYkFfdkNKziZRse8VxBT9sPWnXYrYxlFQVUremGySSsxE8u1
         WUTh+y1QzJPwWsy2+nLPy8GxKYCDwq6tZurWDmDORjvAI2nbGCDQ28eW6l+hj1Q8uXnK
         7aRw==
X-Forwarded-Encrypted: i=1; AJvYcCXeE2qhDTmANI1ZgsxuAm+UxJsl1fXj9NHAQnIskzyUemuNOE0y4C/YU15REifnEJZ7uyiDyK1bvLNOuC/iKGF1eTCfTSTIKhhRiHtP
X-Gm-Message-State: AOJu0Yw+qm9usQvvOV/cxr3rahn4A9tALNi9T25tX0yahp28ROwxs8yz
	N7PDEekmONMC8gIU2E9bb23djDMvk2fNnB1fx6x5WLFXb4q79Zj42T9zuur7TiE=
X-Google-Smtp-Source: AGHT+IHwNiMOfwGTEtSm5pHYqi8a9YlCde2eYXlQmXpSj0XEr1i8os+B9NNEoL8yfU4lANtZTlklkA==
X-Received: by 2002:a17:902:c40b:b0:1d9:4106:b8b5 with SMTP id k11-20020a170902c40b00b001d94106b8b5mr234072plk.11.1709060647382;
        Tue, 27 Feb 2024 11:04:07 -0800 (PST)
Received: from ghost ([50.213.54.97])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709028d9500b001db5753e8b8sm1848211plo.218.2024.02.27.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:04:06 -0800 (PST)
Date: Tue, 27 Feb 2024 11:04:04 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Message-ID: <Zd4yJDAHyZ1lvchq@ghost>
References: <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
 <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu>
 <Zd4h6ZhvLSWfWJG/@ghost>
 <9f756413-806c-4cd0-a6cf-8dd82af14e88@csgroup.eu>
 <Zd4oLnVFJw6Qq0FA@ghost>
 <f95267c0-5d4e-4732-8889-56f7a76cf081@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f95267c0-5d4e-4732-8889-56f7a76cf081@csgroup.eu>

On Tue, Feb 27, 2024 at 06:35:04PM +0000, Christophe Leroy wrote:
> 
> 
> Le 27/02/2024 à 19:21, Charlie Jenkins a écrit :
> > On Tue, Feb 27, 2024 at 06:11:24PM +0000, Christophe Leroy wrote:
> >>
> >>
> >> Le 27/02/2024 à 18:54, Charlie Jenkins a écrit :
> >>> On Tue, Feb 27, 2024 at 11:32:19AM +0000, Christophe Leroy wrote:
> >>>>
> >>>>
> >>>> Le 27/02/2024 à 11:28, Russell King (Oracle) a écrit :
> >>>>> On Tue, Feb 27, 2024 at 06:47:38AM +0000, Christophe Leroy wrote:
> >>>>>>
> >>>>>>
> >>>>>> Le 27/02/2024 à 00:48, Guenter Roeck a écrit :
> >>>>>>> On 2/26/24 15:17, Charlie Jenkins wrote:
> >>>>>>>> On Mon, Feb 26, 2024 at 10:33:56PM +0000, David Laight wrote:
> >>>>>>>>> ...
> >>>>>>>>>> I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
> >>>>>>>>>> defines to be supported" is a gross misinterpretation. It is not
> >>>>>>>>>> "defined to be supported" at all. It is the _preferred_ alignment
> >>>>>>>>>> nothing more, nothing less.
> >>>>>>>>
> >>>>>>>> This distinction is arbitrary in practice, but I am open to being proven
> >>>>>>>> wrong if you have data to back up this statement. If the driver chooses
> >>>>>>>> to not follow this, then the driver might not work. ARM defines the
> >>>>>>>> NET_IP_ALIGN to be 2 to pad out the header to be on the supported
> >>>>>>>> alignment. If the driver chooses to pad with one byte instead of 2
> >>>>>>>> bytes, the driver may fail to work as the CPU may stall after the
> >>>>>>>> misaligned access.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> I'm sure I've seen code that would realign IP headers to a 4 byte
> >>>>>>>>> boundary before processing them - but that might not have been in
> >>>>>>>>> Linux.
> >>>>>>>>>
> >>>>>>>>> I'm also sure there are cpu which will fault double length misaligned
> >>>>>>>>> memory transfers - which might be used to marginally speed up code.
> >>>>>>>>> Assuming more than 4 byte alignment for the IP header is likely
> >>>>>>>>> 'wishful thinking'.
> >>>>>>>>>
> >>>>>>>>> There is plenty of ethernet hardware that can only write frames
> >>>>>>>>> to even boundaries and plenty of cpu that fault misaligned accesses.
> >>>>>>>>> There are even cases of both on the same silicon die.
> >>>>>>>>>
> >>>>>>>>> You also pretty much never want a fault handler to fixup misaligned
> >>>>>>>>> ethernet frames (or really anything else for that matter).
> >>>>>>>>> It is always going to be better to check in the code itself.
> >>>>>>>>>
> >>>>>>>>> x86 has just made people 'sloppy' :-)
> >>>>>>>>>
> >>>>>>>>>        David
> >>>>>>>>>
> >>>>>>>>> -
> >>>>>>>>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> >>>>>>>>> MK1 1PT, UK
> >>>>>>>>> Registration No: 1397386 (Wales)
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> If somebody has a solution they deem to be better, I am happy to change
> >>>>>>>> this test case. Otherwise, I would appreciate a maintainer resolving
> >>>>>>>> this discussion and apply this fix.
> >>>>>>>>
> >>>>>>> Agreed.
> >>>>>>>
> >>>>>>> I do have a couple of patches which add explicit unaligned tests as well as
> >>>>>>> corner case tests (which are intended to trigger as many carry overflows
> >>>>>>> as possible). Once I get those working reliably, I'll be happy to submit
> >>>>>>> them as additional tests.
> >>>>>>>
> >>>>>>
> >>>>>> The functions definitely have to work at least with and without VLAN,
> >>>>>> which means the alignment cannot be greater than 4 bytes. That's also
> >>>>>> the outcome of the discussion.
> >>>>>
> >>>>> Thanks for completely ignoring what I've said. No. The alignment ends up
> >>>>> being commonly 2 bytes.
> >>>>>
> >>>>> As I've said several times, network drivers do _not_ have to respect
> >>>>> NET_IP_ALIGN. There are 32-bit ARM drivers which have a DMA engine in
> >>>>> them which can only DMA to a 32-bit aligned address. This means that
> >>>>> the start of the ethernet header is placed at a 32-bit aligned address
> >>>>> making the IP header misaligned to 32-bit.
> >>>>>
> >>>>> I don't see what is so difficult to understand about this... but it
> >>>>> seems that my comments on this are being ignored time and time again,
> >>>>> and I can only think that those who are ignoring my comments have
> >>>>> some alterior motive here.
> >>>>>
> >>>>
> >>>> I'm sorry for this misunderstanding. I'm not ignoring what you said at
> >>>> all. I understood that ARM is able to handle unaligned accesses with
> >>>> some exception handlers at worst case and that DMA constraints may lead
> >>>> to the IP header beeing on a 2 bytes alignment only.
> >>>>
> >>>> However I also understood from others that some architectures can't
> >>>> handle such a 2 bytes only alignments.
> >>>>
> >>>> It's been suggested during the discussion that alignment tests should be
> >>>> added later in a follow-up patch. So for the time being I'm trying to
> >>>> find a compromise and get the existing tests working on all platforms
> >>>> but with a smaller alignment than the 16-bytes alignment brought by
> >>>> Charlie's v10 patch. And a 4 bytes alignment seemed to me to be a good
> >>>> compromise for this fix. The idea is also to make the fix as minimal as
> >>>> possible, unlike Charlie's patch that is churning up the tests quite
> >>>> heavily.
> >>>
> >>> Do you have a list of platforms this is failing on? I haven't seen any
> >>> reports that haven't been fixed.
> >>
> >> I don't have such a list, but I guess you do ? If all platforms have
> >> already been fixed, why are you sending this patch at all ?
> > 
> > This patch is what is doing the "fixing". Over the course of 10 versions
> > I have "fixed" the test cases to work on platforms that have various
> > alignment and endianness constraints. The endianness changes were picked
> > off of these patches and spun out into a different patch by you.
> > 
> > I originally introduced these two new test cases since I wrote the riscv
> > checksum function implementations and these tests were helpful for me
> > and I figured they may be helpful for somebody else too.
> 
> I see.
> 
> Then you mis-understood. I don't say your patch leave any platform 
> unfixed. I say that your patch seems bigger than required, it is a 
> churn. In addition your patch assumes an alignment of 16-bytes which, as 
> explained by Russell, it just wrong. At least an alignment of 4 bytes 
> must work on any platforms because of VLANs.

Pardon my ignorance but I do not understand why VLANs cause this test
case to be incorrect/introduce churn. The VLAN tag is a 4-byte field
that is optionally included in an ethernet header. This causes the
header to change from 14 bytes to 18 bytes. If the architecture defines
NET_IP_ALIGN to 2, this pads the ethernet header by 2 bytes, causing the
payload to be aligned along 16 bytes without VLAN and 20 bytes with
VLAN. Another test case can be added that aligns along 18 + NET_IP_ALIGN
but that does not achieve the goal of reducing churn and I would not
expect those additionally 4 bytes to highlight bugs in any
implementation.

- Charlie

> 
> Christophe

