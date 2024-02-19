Return-Path: <linux-kernel+bounces-71705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0685A94A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56051F219E6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9D4121B;
	Mon, 19 Feb 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="Aht04YIs"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441240BEF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361359; cv=none; b=QxrtER0MpCkri9eOeIjIQg1MYNZKt2/hK5e+8pktlxB9/S//7lXCOsHheWOnUGV0jKmtyLWLeWgkEgX7OW3MfXpSNtQou9nMfhBZUN62jpkkmlgcELSL25W2HIOk3h9gBIEmcmqm40aI4Oak3M/J6JqvHRy+5/6wdZJvh8HBsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361359; c=relaxed/simple;
	bh=XrFdfPaIWYKoATTzYO8ZkjWEledo7tchXzn7eTnVRQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPZAcKBHAlWK+wjJ1Ilvd83Iof8/yLIUU5OvcKnHoiW/N+j/8xRuQ8TJscfCQMQXnLR9MGPPwwPmk5DmiDSmifdAjclQKNLrF4ByFNlficgaV7/QnAsqkt+oSicHqsLoifZ2GsY6XU6+qbARlILAJ9JP4QjAHmPY//DEUw5aCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=Aht04YIs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-299846d6ccfso659514a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1708361357; x=1708966157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lMzbUHJUYGeXk+CET5Q+3142q+taOAWUZQVuI/SucM=;
        b=Aht04YIsHu7kWDBPtqO+BPMgbbjgTNjA1Go7hQiue8DVqeoE4hUcet7uSa9PyiGUXm
         F+XXllk2GVcKGieVZCCTMPjC77IwWowPGQxMqtE1kADpdF4PWrLn3oE1VH6yk8iNsVSz
         VC8lRak3EePmf/CzgYueLM1SDWfvSB0I+aEmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708361357; x=1708966157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lMzbUHJUYGeXk+CET5Q+3142q+taOAWUZQVuI/SucM=;
        b=YearY7YuXzmMDiBR7xL3VIx7/U9fny/xBj7MlUemoQj8LhFj7XVFyvXDLRlbG7VQpJ
         rRQ/REMgw873DiIS0vxKrsipNy8MKArEpTO8sSH5/+JEc7knN+iLMhTZWh434tdp/33A
         /X9kwnWtl6cvvJty+fABHAY4A98NQpfpH3pFMWNxNI/xlmLMb9rvr0HxVmYyyhIwDCv+
         o9aBXbc+AjDJEvO5XzPhL6+fGz8XgAYnV5tyTJA5Bhym31hTMQL0VjWd7HFdDDJwoY6u
         s22yYbkyY0oSNYpcr6A18RTgNOVPShDTreOQpWOqlHN4K9sljkUJJ3XgN6/SkhkQaG2e
         BMJg==
X-Gm-Message-State: AOJu0Yyi8Sn+B7UlfpR+iBCOIKadjExq0o93tjYiXlSEEIQPsheYdtNG
	CmBXAZnK+P6gnVuRkoIa50yrd19QyQTUWca3ppUWBjZklO5qNwax8JJRvr223WV29M3EFYHF9h5
	T+eYO2yuaTQd/GdmvwgOqulcVXFGXZWIs/iQQ6OlK6UGjuTH0
X-Google-Smtp-Source: AGHT+IHzazaHbqvAWKhqrP4CycuDtGFRbx5HBfazYctqOUAOazrXsnc1yXPu+PInivQnF2bZ0DZMh47uAZh+zSHJMlc=
X-Received: by 2002:a17:90a:f98e:b0:299:8942:a35c with SMTP id
 cq14-20020a17090af98e00b002998942a35cmr2381033pjb.44.1708361357424; Mon, 19
 Feb 2024 08:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9zADyveGGBNKsD-JFoOeGZ3om3wMhkqvPc2mvxp-yBzk5mrg@mail.gmail.com>
 <f8a92dd7-8509-428d-8982-4ba94063081c@infradead.org>
In-Reply-To: <f8a92dd7-8509-428d-8982-4ba94063081c@infradead.org>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 19 Feb 2024 11:49:00 -0500
Message-ID: <CAO9zADxtxd6ZSBcy79fCuCRbZFha6i4d-XW13f5smn0J0Zay8A@mail.gmail.com>
Subject: Re: Linux FS6712X-EB92 5.13.x - page allocation failure followed by a
 controller reset and the drive drops out of the array
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 11:34=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi Justin,

[ .. ]

> I can't answer your question. I suggest that you ask it on the
> linux-raid@vger.kernel.org  mailing list.

Thanks, I will follow up there.

>
> Also, I have one question:
>
> in this log fragment:
>
> [1698614.263935] SLUB: Unable to allocate memory on node -1,
> gfp=3D0x800(GFP_NOWAIT)
> [1698614.271680]   cache: skbuff_head_cache, object size: 224, buffer
> size: 256, default order: 0, min order: 0
> [1698614.281979]   node 0: slabs: 32, objs: 512, free: 64
> [1933116.236646] nvme nvme9: I/O 119 QID 2 timeout, aborting
> [1933116.242365] nvme nvme9: I/O 120 QID 2 timeout, aborting
> [1933141.324640] nvme nvme9: I/O 1 QID 0 timeout, reset controller
> [1933146.444701] nvme nvme9: I/O 119 QID 2 timeout, reset controller
> [1933215.826997] nvme nvme9: Device not ready; aborting reset, CSTS=3D0x1
>
> there are roughly 4 days between the 1698614 log entry and the
> 1933116 log entry. Is that (logging) accurate? Did it miss anything?
> It just seems odd to me.
Not that I had seen within the logs, when I tried to access the device
via Windows file share it had been awhile since it was last accessed;
however, there is no sleep setting for the NVME SSDs (only
external/USB HDDs).

