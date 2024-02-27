Return-Path: <linux-kernel+bounces-83785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC21869E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06C91F29490
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6374F215;
	Tue, 27 Feb 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ9e4dcc"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE374D9F0
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056625; cv=none; b=QjOhGt071VHSH3r5/rfXQK9RQnPPXX8UqyGDX3ZkGXDlV66EJ/2S5E3SO9Yhp7PJqo+LF5zV8ggHu1vkITQ7Jiv9dVivJ1fhB41LX0MSbzR54c4iwq3hfgqcHbCgUsryUpVmCeLfvU92g9qQhZJJu9YPKr7w8XPMvwp9K4ohZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056625; c=relaxed/simple;
	bh=BMctpladojexLlSRJ2/geKUZZuJ6U4jXTGyi4yy31Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck60Eq6PhHbAlSFeNUih62APS8MFTo8htNqV/NXJDosCNQzfUJmzAnjG/dXUYjpa9sgVOHz4kt8yUTWKbKOennbYztaekKhrXnexzY+yOMyd1fERqV7rhx9JuzIyZPGtMOw9wuKiyubTQ4Ahox3YLN9vV0mnoP8Cj2/9LLaC0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ9e4dcc; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-47048ea1b17so561071137.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056623; x=1709661423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0OvnMlkLPVlrxgOFiGZF4MuyVJQ7RsxxiPv5dVay/ns=;
        b=QZ9e4dccEH2OtPiSRo3uQX9v1Jlm/21FQ8b5g98r+keHz26JT7XJut6pzXEoVkYWKD
         LaVSb8GFB+zr2OV26heDGFMK1lGTkh1NBxTXutz3EwgtTZ0MnA5koF3a3tATXKAO9jJJ
         OU7RS9Cuge3vsfO0QnbZ/vRgtZrqsQuORbAc19AeYm/P0JYjOGDu4pXOllUrkZlnvAke
         SqXSE3ultajDU/Fxo0bUGSm1nU2pKBR2t6tcaG1Pw4HCuQv20eWr/oi+L/K3rReBNfSp
         Y1NoV8WqISx5/HwMrkWxZLtXyWsWPpkv8ctAdoSV0lH1CwUeOdod/exZP5IPQM70e4i2
         id0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056623; x=1709661423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OvnMlkLPVlrxgOFiGZF4MuyVJQ7RsxxiPv5dVay/ns=;
        b=D7cbNKSLNnA0o8+daNc3A8d7zhwnxw4cv7Y9uNnesNac5u+sv61+XG1+BHaIeIPlqK
         q7p9KU0+FxdoAKMtiZI+tgZt9QJKzfPXoed8bTnKp0QTPzsap2osFw2ECYtLkdJCqWyw
         g4EerpTr4b6YN6awDzq4p6+jWGAp+LHTJ4OHKbldIUsocv+IKvG+PcetfLTjTctd6vZB
         fyWgEjsfrCLwCh3BgHdF1Sjcjb+TkSmJdkRbCIq93bkV0yEWBGjiAdEyUoWVELeC4BV2
         kMystN7nmeIPJT/ZviQZyjFf3leAz/73DUEDt4ixp1t3eM+Bs12RaWPZbPKfN3plOblD
         Qhbg==
X-Forwarded-Encrypted: i=1; AJvYcCVW0mcYY/ES7/orDeryJ2GpOkNI+Q8SkU3eeR7aN8HMZZdhCNEgtsqOnAm6iEwZKS6o1ifV8puBnK4LQn/kh3fkc3erQVIr1auXkS7f
X-Gm-Message-State: AOJu0YxjBZUXhPHawNgk9EHCwhvTpLkwEZATL+r+cEkJcdgoVG2jTDQC
	lFNgx9nNw3qZ6z9pLQFewyHdehGG0VEJuwz5O2Rb/wkySRHPhox9WUmP9VLln9gua2ECSMRjpKA
	2B2sFipRQz9zA+d24FP3fKGPV+6g=
X-Google-Smtp-Source: AGHT+IHDFU5YAuuQyKynl8X6whEKFL65QwcQH1i4TtRa/MBVObhIqYXHZKIUeyVaCsjH5c2+HrUjoOmuqdDoInTT7h8=
X-Received: by 2002:a67:eeda:0:b0:470:50ff:d9a4 with SMTP id
 o26-20020a67eeda000000b0047050ffd9a4mr9673857vsp.7.1709056623078; Tue, 27 Feb
 2024 09:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <ZdUK1jhMUSyC7yUj@slm.duckdns.org>
 <CAOMdWSKrcRFUsFc3a0+2Js5hOA92xeQSkS06oL9VgSyZpDrO8g@mail.gmail.com>
 <CAOMdWSLjk8pZUgM6QHdeJ3C8Q-Y07GM4QuaSyAyP2jZcAMLOhA@mail.gmail.com> <Zdzav4yCFI0kAx7o@slm.duckdns.org>
In-Reply-To: <Zdzav4yCFI0kAx7o@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 27 Feb 2024 09:56:50 -0800
Message-ID: <CAOMdWSJdaBZahLvbEqwG_x4bnoRxLAfvmCngqyUvL9dbg0DF0w@mail.gmail.com>
Subject: Re: [PATCHSET wq/for-6.9,6.10] workqueue: Implement disable/enable_work()
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Tejun,
>
> Sorry about the late reply.
>

No worries :)

> On Thu, Feb 22, 2024 at 12:26:35PM -0800, Allen wrote:
> >  I do understand the work bits, but I don't fully understand the
> > concept of colors
> > (work_color, flush_color). A swift overview of it would be highly appreciated.
>
> That's just to group work items for flush_workqueue(). Let's say there are
> work items which are queued in sequence, 1 to 8. Let's also say that there
> are three flush_workqueue() attempts which take place after work item 2, 4
> and 6. Then, the flush colors A, B, C, D are assigned so that:
>
>   work items        1     2     3     4     5     6     7     8
>   flush_workqueue            ^           ^           ^
>                     \-----/     \-----/     \-----/     \------~~~
>   flush_color          A           B           C            D
>
> and the flush_workqueue() code waits for its preceding colors to be drained
> to implement flushing.
>
> It's just a way to keep track of the number of work items in flight which
> were issued before a certain point in time. It's expensive to do that for
> arbitrary number of points in time, so it just has N slots for groups and
> calls them flush colors.
>

 Thank you very much. This is very helpful.

- Allen

> This shouldn't really matter for the bh conversion given that everyone
> operates on individual work item.
>
> Thanks.
>
> --
> tejun

