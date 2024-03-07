Return-Path: <linux-kernel+bounces-95312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6D874C13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7554A1C21ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4008529D;
	Thu,  7 Mar 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="VLneGRlf"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526ED8528F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806403; cv=none; b=ZkznxmaaPsBA0e8D0SS71xKYOK8Askl+d6pevwlIuxDdq6DyoNVsY0dccptfHiEDr6EisF7aQVrxCKOUqMIevhTV8WujyR2yn5nfkEwGpSjr+hpj5oBwiWeOZZUGunkltouv+tuXXmNdgewGyDuTrmx01UElJEawsVULQiXZYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806403; c=relaxed/simple;
	bh=KPfbW2lQX/bJg7kEZFYwIIRBOeQ37xyQSbgAoCjTrbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XxS0TGYNK3dE1T/hUk4ueif311rXauXS2NM/xq+RCLvSmGUq1I/olRQglB0h3iQ+TFF1OwvOK0MnSwne+YwDFFjdiHo/tjV4u55et/A77IyJd43atdIiZ6joO5sXifF5bt+VtWrhlA5gGbrGRGBizhZwMwxCqxrq3ez/yIz/d9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=VLneGRlf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29b54503280so391616a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1709806401; x=1710411201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KPfbW2lQX/bJg7kEZFYwIIRBOeQ37xyQSbgAoCjTrbE=;
        b=VLneGRlfQEidOvTjDa//8OrSlNr6v+E1zFDntkew+xEFl+rRX99EXZo+ew1HhJkCW+
         cwTJOcxYSYdJNM+KVsTfu4fH0VVhwcIjAUxuC6b8CJ1VfPzs8c36DM8lp0wtvq93XNMW
         xabAYjuxtO6DCghfy1RHAIQ+xhzOFJx70B3G76gVGFM36rjeCUx6CEy1Z1FWw1w2BfXP
         +TsFCDIA0N+0VW1/PKfaR/vf+w8chNpxf482omt1aFxO6Xjhhqt2i50C3flz/LAtV+YN
         yn2Bu43AJW1aITIiCVjDSkNAVeqdYrKgF1SbawXJh50XEEZO9rqkQ36EtiuCLTOa6w0w
         WlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709806401; x=1710411201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPfbW2lQX/bJg7kEZFYwIIRBOeQ37xyQSbgAoCjTrbE=;
        b=RjLukG1+BV+eH0IoFL1N5AnFAR5oXXARcgPiamfxB7lIRUOpFzBCM0yC/B+E6f88as
         VhOv6cNJiEhEcK+KRVj2usPd/p4aMF3WzGakHz7I25RHqUxyEJ7MwTWPkYmDjwzX1/Zy
         dAzApzLwxJKQKbl8KahVq9dUCZmKcMax9BWpRxngHl91aYG/ueZxPTobwY2hc6amTtCb
         KqqL4Ig+RZtTme4IP1vN/PKDBnqnkkXoctTNl3Qi2M8kEfEuPqtSh2WevzABaONp0ho8
         ydR9NUGZ4QgIyWUta5LY0YDYESldMtZUJ3vYbvsvqaZyuvj8lwCPSmD2jSDPH7RpA6LR
         U0cA==
X-Forwarded-Encrypted: i=1; AJvYcCWZO1fJ/NJ5CfAG1zWNJYqdDa3XX8IwXhoNvZJ4h8mSBKRpysMw1L0/ZV1XSJ2g6RFjMt6qbUR31o/yhQqWpDNZOCPArlhLfp7eJcXX
X-Gm-Message-State: AOJu0YxRq5Q231eIn2JVC4r60vrEXYrRmwU8wtX54PdrGdGqHNW1Bc3M
	5kQzs20RQiI3IZLFpodIV/S3T8Bktfge6k5iqMJBHnrPR0CMn8GxtKY2pmFbL9A4zn/SGmBXEvU
	9+ETSAZjR9Abk60XDa8la7jk0vtvJzKPqTeEnlQ==
X-Google-Smtp-Source: AGHT+IGTeiuRWXfAKAN+bzQz32OBrz4/khXPlf49jXRu/+k3YnYjuC0Iw+nbitbKtncVWjYgrCxnDKvNp+2E5ZP06b8=
X-Received: by 2002:a17:90a:c7d5:b0:29b:9b4a:99b with SMTP id
 gf21-20020a17090ac7d500b0029b9b4a099bmr364557pjb.3.1709806401537; Thu, 07 Mar
 2024 02:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305210747.1377506-1-naresh.solanki@9elements.com>
 <a32a2655-7561-4339-8521-bc2558e0bdb1@linaro.org> <CABqG17hYK8MFMPVNXxZ6JT4TW00PPt48q1qZBzS=gJrpC--iTg@mail.gmail.com>
 <20240306-decay-overbid-9c8ea43a511f@spud>
In-Reply-To: <20240306-decay-overbid-9c8ea43a511f@spud>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 7 Mar 2024 15:43:09 +0530
Message-ID: <CABqG17h5fU4nueaz235XXjJwuPJoLmjo3fs-xZ5mFjtGGYQFkA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,


On Thu, 7 Mar 2024 at 00:08, Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Mar 06, 2024 at 03:20:02PM +0530, Naresh Solanki wrote:
> > Hi Krzysztof,
> >
> >
> > On Wed, 6 Mar 2024 at 12:44, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 05/03/2024 22:07, Naresh Solanki wrote:
> > > > Add properties for interrupt & regulator.
> > > > Also update example.
> > >
> > > Nothing improved.
> > Yes, Just aligned the regulator node name in this revision.
> > I missed aligning the commit message.
> >
> > I'll fix in next revision & update commit message as:
> >
> > tda38640 has a single regulator output along with
> > CAT_FAULT# pin to report internal events.
> > Hence add properties for regulator & interrupt.
> >
> > Let me know if any others changes needed.
>
> That should be fine - but your line wrapping is really odd, you can make
> use of 72 characters but you are wrapping at ~50.
Sure. Will push another revision with the changes.

Thanks & Regards,
Naresh

