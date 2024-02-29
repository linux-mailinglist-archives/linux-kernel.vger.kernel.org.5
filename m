Return-Path: <linux-kernel+bounces-87706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755586D7F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91171F227DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CEE7D07F;
	Thu, 29 Feb 2024 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="L1dXKeSD"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9B17545
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250041; cv=none; b=NaQBEWIFCObvNhGtBfRe1i79KznIfs+pNMGvPgs5vdBxfPwi+KaDY0RBkYNwUFiHHyWQEz5qCMIj65RY5QGOdnUJX5PUHYr8oLMrF+6aNmBvd4k3HxQAdqXBeOohcL22uhstAwJ22lRxO43GViSoo6+HgkukWatjtUNlSIpv24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250041; c=relaxed/simple;
	bh=YINVBLnxrq+l39FJyQ3fbITB0i0PTuuWS+US1jLsYZQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=sNRIj8kmOdBQmeS57wNLG9fagKaKrbFwtqeK8xh9l3RdIB2GqeApOlZvyE8YEk4jeqwGhVA5UD1+KX0Sogjbo6ArIen6J2iXZmtL0LHUdRZtUDLcKxBgYCrl7uIh/ESn+8TaIqVXm1u9XnpiQAi46NFQP5/UOuEiY98iWxLZe/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=L1dXKeSD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e56da425b5so1194655b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1709250039; x=1709854839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lx8BWhywoDIgpgt+e03ZrIqlEHq0YVesZbrDMn3IG9M=;
        b=L1dXKeSDFIjfvffS2m5a1b8sh4JIj+PRoGkPaID2+IzmK/qxjuEYU81sc7sIC5F74+
         AMB10CZJyCUT2y5/uYfODUt+82yZX7jxEmHJY/u9uitrsmVRaqG8VkUARKWdT0Q7eSeM
         twggHu2Rfr9YS0swOoZaj4EgYlhuW/vHruS1TNvtA38PW3KxIEDmrD4bDLfjl5hvdxiF
         nsecFpa2qhO6ezebLH/LVxelsxNR0CqdXyQoqLHIKUw2uI58tJg0HAGpV8hlNy05/xjt
         9dQN69M8CdwHOMd34IHMmnf8YkdBtjIqWIe9FQvplRhrEQX/iWzdWoDt47pjY8aH01QY
         hgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250039; x=1709854839;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx8BWhywoDIgpgt+e03ZrIqlEHq0YVesZbrDMn3IG9M=;
        b=GN6jqNkOuNVGRa6NO+ZuXtG/caLsA5OqqdH+CgoiFRETh8VeHBe/7lWDRtTd4U5FP4
         2aLWwon1Z7EgH3hbYwjdrIGWVaxdRuvI9f2rIfOusYlMX+ZgJycfX0RKohOagx57USRm
         qikHykdp5gjOZALX5pwxPCXiyleJRjC/tC/lDM+WSF87j2KTGXoOl3kGg8hQDLWBglAz
         vuDKF1jnfUSYskn1uf82692HA3kq7NeFcwozVtRl6HJhBnhZyHKS/EfFdsMVItM47Ix7
         UZ4p6+HoYdgXcBNJXhjbnvvOFvCs3L6OuLAHXTjSoUq1XG0cjyrBsZntvK6czli/A9+H
         gpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFaUZvq9/jUTluFaWtoTj5CAXv3PscnSWIrRZ/aNXDm0j0YyColkTV3TPpV4qNWR2Qz1sDWVe3fE5jbyEN2ik+nImjKdwG+TMrC8Eo
X-Gm-Message-State: AOJu0Yw2C2OHGyWvWEFY8vQj8pCq531PeQzyV0tOMob7qplLvTQN3ZAp
	afWchXYP84Z5IZWrW+XgdpIq58v8DL7TjEgIkJ8X7H+D9vfjRyC4ywyBMGHj3HA=
X-Google-Smtp-Source: AGHT+IEP0KUN5vieOSkjcb6f/9wrtZCWTiS6hFvutEkB79kR+hMPoz0zBj3WKb8OwHFOckN1Bdptdw==
X-Received: by 2002:a05:6a00:188b:b0:6e5:9698:7cb9 with SMTP id x11-20020a056a00188b00b006e596987cb9mr278229pfh.4.1709250038519;
        Thu, 29 Feb 2024 15:40:38 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id k16-20020aa79990000000b006e59615812fsm1693015pfh.213.2024.02.29.15.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:40:37 -0800 (PST)
Date: Thu, 29 Feb 2024 15:40:37 -0800 (PST)
X-Google-Original-Date: Thu, 29 Feb 2024 15:40:31 PST (-0800)
Subject:     Re: [PATCH -fixes v4 2/3] riscv: Add a custom ISA extension for the [ms]envcfg CSR
In-Reply-To: <20240229-establish-itinerary-5d08f6c3ee43@spud>
CC: samuel.holland@sifive.com, ajones@ventanamicro.com, linux-kernel@vger.kernel.org,
  alex@ghiti.fr, linux-riscv@lists.infradead.org, sorear@fastmail.com, stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-0128d165-88ba-4952-b875-c35b06ce9224@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 10:30:10 PST (-0800), Conor Dooley wrote:
> On Thu, Feb 29, 2024 at 10:23:39AM -0800, Palmer Dabbelt wrote:
>> On Wed, 28 Feb 2024 02:12:14 PST (-0800), Conor Dooley wrote:
>> > On Tue, Feb 27, 2024 at 10:55:34PM -0800, Samuel Holland wrote:
>> > > The [ms]envcfg CSR was added in version 1.12 of the RISC-V privileged
>> > > ISA (aka S[ms]1p12). However, bits in this CSR are defined by several
>> > > other extensions which may be implemented separately from any particular
>> > > version of the privileged ISA (for example, some unrelated errata may
>> > > prevent an implementation from claiming conformance with Ss1p12). As a
>> > > result, Linux cannot simply use the privileged ISA version to determine
>> > > if the CSR is present. It must also check if any of these other
>> > > extensions are implemented. It also cannot probe the existence of the
>> > > CSR at runtime, because Linux does not require Sstrict, so (in the
>> > > absence of additional information) it cannot know if a CSR at that
>> > > address is [ms]envcfg or part of some non-conforming vendor extension.
>> > > 
>> > > Since there are several standard extensions that imply the existence of
>> > > the [ms]envcfg CSR, it becomes unwieldy to check for all of them
>> > > wherever the CSR is accessed. Instead, define a custom Xlinuxenvcfg ISA
>> > > extension bit that is implied by the other extensions and denotes that
>> > > the CSR exists as defined in the privileged ISA, containing at least one
>> > > of the fields common between menvcfg and senvcfg.
>> > 
>> > > This extension does not need to be parsed from the devicetree or ISA
>> > > string because it can only be implemented as a subset of some other
>> > > standard extension.
>> > 
>> > NGL, every time I look at the superset stuff I question whether or not
>> > it is a good implementation, but it is nice to see that it at least
>> > makes the creation of quasi-extension flags like this straightforward.
>> 
>> We can always add it to the DT list as a proper extension, but I think for
>> this sort of stuff it's good enough for now
>
> Perhaps good enough forever. I was not advocating for adding it as a
> permitted DT property - I was just saying that I didn't the complexity
> that you mention below, but I was pleasantly surprised that the stuff
> ?Evan? and I came up with allows for this kind of inferred "extension"
> without any changes.

Ya, I'm in the same boat.  I think we can get away without putting these 
into DT until we end up with something odd going on, like some other 
flavor of *envcf from some vendor being weird.

>> -- we've already got a bunch of
>> complexity for the proper ISA-defined extension dependencies, so it's not
>> like we could really get away from it entirely.

