Return-Path: <linux-kernel+bounces-102754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886987B6E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CE71C20C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B48BE5;
	Thu, 14 Mar 2024 03:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe32lMIL"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A5610B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387555; cv=none; b=X6AqB/xUXoE4PLAL0okItZ+o6jP4J+Y08HwWe+XUNJXiZYGakLKwcuhqq+Xgm0RRXrAk9h85G2lGKVeXEd7ZbYnJ26giAbW8XfQPEudGef4F9d/5z9k9XsVxUlJ31HO4tY7KbvJy8vN+xx7fZ/4xIiiRItpcFXEaRUHUIb6Tdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387555; c=relaxed/simple;
	bh=9sTj6HSQsMbpahZ5gzFwnQcYihpItAs7FyYnvATq2Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrUNHOIgMWlRPs+r/v6BVmMBOnsSYgX3YXTUks7FbGyljzZ2lzhEvHKbxlp9Fh9ar2fVb3IE2d9OniBpdOaIGiALEi1mv9eR7A2P12DBasrmyN+PyA9NO8MYjLBH8zJO84k1b66Mgph0xm7w1kWl47jJeaIYcDFjhcSlWway3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe32lMIL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51321e71673so649923e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710387552; x=1710992352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzfB/zx1rMXFiN5xVYxoTP9vNrcpsloQVQWggT/ee1M=;
        b=Pe32lMILjfmcJf5LrlyqRyonE6m2Ww8LhYaHUMLAFQMkqArcdjmVu4Y2UUFwV2XD/8
         97WO3yqFiXTVURK0KBYy3fR3zevER8PZFf+Z1yFaGnVw9UuzeC3hmGgye2KVdzmcNVLF
         MT+Y/YLgqp61FizEHLzMWANBIDcg3tRTJLhDPRXab2fNES/bMUEz8Llo00DbVK3BZQBk
         ZDr9x3oLi5UdV3k3OgORVfvPsXb5QfJ3a7E/EeWUtQMqOm/V0/6n5aoP3+zKZNR+/4/H
         A+c2grXm4gkgGJViLJGcSOfId0GsmAUJV9mB34BuL13SFBqM6OCp5KDsUXYVsZJ4LelY
         nWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710387552; x=1710992352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzfB/zx1rMXFiN5xVYxoTP9vNrcpsloQVQWggT/ee1M=;
        b=qFLsfv89gnrPuldv789Cq0TwQ+tJrD3gVYdmr9qYlnr7gnJjBYticq1a9NA64WyN5s
         03zVmVOPNmYGrypwOfQ2vTYeMej+6Z1cI8P2m/Zj+eHLGkj/sQDBLNmpeEgvOwQ9i+EB
         U+GV/ULC+w2rW0059hePT61j/XgUHJKl/RKT+jbkBJK4QHqskN9EPR4N3oJfEKeMrx5Q
         ffOdbLMUxqUTr4pt2Lej4wKx/NJryUg3ktVPfgXWHKkYMGM55WFBRLntlMlZCnn5gC7+
         ZLe9WcYo1xwqpEeaXIXI5oxVErJVFaBfWY7Qr1rC/SRsTBn4gaJNAg01q2iuJWPHPu2g
         +M/A==
X-Forwarded-Encrypted: i=1; AJvYcCUowtOQjX2cpbratZaO8chps1jNCRehnvLnONnUHLcQxjwejFjUI2/Ou9P8hld49BR79/LAiI/Ax/9bFHVlhqlv2kN7YUP6ffFZYn2E
X-Gm-Message-State: AOJu0Yy/0Iz0hRTwUqFUeZ4W00U5JunLXBf9UH5TltPKl/du4Im8Bd7Y
	tJrfhpS5/arbLFnXOSVXEKRstYHY/mlKhvbX3VpKkuI837ojtXAHgla0sQ6tSOOPztB+5Hp8IsA
	MzbGeR7FwgPNCiHe60JnbBpb2S/5jiBFT
X-Google-Smtp-Source: AGHT+IFU7eMwlTFR5WfSDoIvTFz0pq0Wqj+p6dNE4PgtQyYt1KURs26skGTJXhIZ1vwCI7FP3a7rUPZXADl2pnbFfq0=
X-Received: by 2002:a05:6512:32b7:b0:513:c9d2:e1e1 with SMTP id
 q23-20020a05651232b700b00513c9d2e1e1mr263956lfe.66.1710387551954; Wed, 13 Mar
 2024 20:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twR+WnE3GGqyeh1cuGVmpADPTwDPK10625RP--rLrqkxA@mail.gmail.com>
 <CAHk-=wiTWLKkg0Hht4ofDTVsebD2Zq-m4UP-DsiZjM+w4b7qug@mail.gmail.com>
In-Reply-To: <CAHk-=wiTWLKkg0Hht4ofDTVsebD2Zq-m4UP-DsiZjM+w4b7qug@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 14 Mar 2024 13:39:00 +1000
Message-ID: <CAPM=9twwZ-u7_8sRRRf5kRnuRa44ixzM8dHZUs6f5wLnQi90Zw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Animesh Manna <animesh.manna@intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 11:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Mar 2024 at 21:07, Dave Airlie <airlied@gmail.com> wrote:
> >
> > I've done a trial merge into your tree from a few hours ago, there
> > are definitely some slighty messy conflicts, I've pushed a sample
> > branch here:
>
> I appreciate your sample merges since I like verifying my end result,
> but I think your merge is wrong.
>
> I got two differences when I did the merge. The one in
> intel_dp_detect() I think is just syntactic - I ended up placing the
>
>         if (!intel_dp_is_edp(intel_dp))
>                 intel_psr_init_dpcd(intel_dp);
>
> differently than you did (I did it *after* the tunnel_detect()).
>
> I don't _think,_ that placement matters, but somebody more familiar
> with the code should check it out. Added Animesh and Jani to the
> participants.
>
> But I think your merge gets the TP_printk() for the xe_bo_move trace
> event is actively wrong. You don't have the destination for the move
> in the printk.
>
> Or maybe I got it wrong. Our merges end up _close_, but not identical.

You are right, I lost a line there, I've repushed mine just for
prosperity with that fixed.

The other one I'm not sure on and will defer to the i915 maintainers
if ordering matters.

Dave.

