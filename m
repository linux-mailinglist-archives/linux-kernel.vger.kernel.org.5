Return-Path: <linux-kernel+bounces-57035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAE84D311
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93171C25A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785FFBE8;
	Wed,  7 Feb 2024 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="k6aoA6gW"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198A1EB38
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338107; cv=none; b=HkCvfvQ9sQWY+cl7S7PIM8MAMD2ZGwHisCAh9mMW2snKKb0m8BJQ/yalYrw/baKKtmL3ZLGlddIVwNtHvRZ9LDn7CJWmAETPXuvXr/k4Yr5hyNVk1wsXwOBnGaDkzmk/RXsAiNNdnYdRduj/IC0wgkKkbp6KTghIxx9ntwK0NVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338107; c=relaxed/simple;
	bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O/tgTlU6fYl5A3qwlK2F52Fd6q2/M96/PCG91QBr7rlLLVdQpuzIzo0CRZAJkPJ8GlP0DXyMGr4nrRSvV9dPg6dlLfUeCAqX9bqrcXyl/b88TAyso8077gCyCNF+qALEq1d5p88tT7r2dUxznsGx725cn1mqHzlAMP/gzN0J/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=k6aoA6gW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b276979aso765035a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1707338105; x=1707942905; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=;
        b=k6aoA6gWL002h8P2zXOejqp8noIzeX4H2XusvBCr+UYR9KHQl7Y1LoIVx/JU66Zu/D
         ePOb9j29HCpVW3NkPdSv+/mWpouGODngz08IwdF7sr3EBqXJAxWEN7smzDtXGwCz1DxL
         DT4FuJlRapYUNMKgJa+jNIjDL3LllrxAZvGwHI+5viUvK5sz03fhk4+egXTLIiZ20BCw
         r/yxMjdRMf8ubzi/UNm5hVIgABRvdmugIdriKyseW2Y+LsRvL56lWRUxOrgBowWNujyi
         RpUtjxKKWueSegvDllzxNzRNagE9CP+mvOB5a1Ee4/h+fS6zQk1Qv51vPVHerZO3EvLv
         soZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707338105; x=1707942905;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=;
        b=urdStiFZI7fQZKmz005/m8x8Z1aTQRpHX3S/QyiQ6CsKKOyA0Bl+tFqVj+gZAf/UR5
         h6lZ2UHeRfJFJNfuZYbGYjusK84eYyiNaHNYTDAg/oOTp/56DoHgK34WAw88C7Hja7PR
         G2cmryOMEDwtYaBPTwwYoPOKJemnRJi5UtlzSZGDUZeorwtOvmuOj+3yir+4wpR6waMS
         VZR1HyyRUv+g1fxgCOCWPBX2vPQDKf5fUR2v62usNQGeRrlKlWXaKUpcUH91ctQzS0gd
         2+hpgslbuUC4Ub6bhmIE+kto2qQZCyssKoLak8az8CPJm6Dkk6Z5YWCqr5PpDiS7wIPK
         ANkw==
X-Gm-Message-State: AOJu0Yy/ObHrbM+LQeksJFtCW5aybPsfK8283RVaKyCu1IuSSByzcmuJ
	CGk1St8+iX6X8/W4fioOvxFtqE247+yfrFm1jIUaVkNZDyFWPhJtIy+VcIJBU4WGDyTx1WMTKpM
	04DmsR10mFVB3o8vYwoPwO8vSLKdoQ8YGemLG4Q==
X-Google-Smtp-Source: AGHT+IGG+jMugKQsGtnsDpLxeX635/9flpe9WYYdtfpZiAfBXQJ/h2yWeqKomRpEPSdDF0AvOQx/MxjPQQIih4x/IrE=
X-Received: by 2002:a05:6a20:e608:b0:19e:a3d8:fb5b with SMTP id
 my8-20020a056a20e60800b0019ea3d8fb5bmr3344322pzb.56.1707338105218; Wed, 07
 Feb 2024 12:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeremy Allison <jallison@ciq.com>
Date: Wed, 7 Feb 2024 12:34:54 -0800
Message-ID: <CADfv6Ka0M947muKa7hSuVv5Ot_tonmFNBYyrkzCQ5_KUVqN6YQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] async device shutdown support
To: linux-nvme@lists.infradead.org, Jeremy Allison <jallison@ciq.com>, jra@samba.org, 
	rafael@kernel.org, Tanjore Suresh <tansuresh@google.com>, linux-kernel@vger.kernel.org, 
	djeffery@redhat.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"

> This is another attempt to implement an acceptable implementation of async
> device shutdown, inspired by a previous attempt by Tanjore Suresh. For
> systems with many disks, async shutdown can greatly reduce shutdown times
> from having slow operations run in parallel. The older patches were rejected,
> with this new implementation attempting to fix my understanding of the flaws
> in the older patches

Hi David,

It may have escaped your notice that I was shepherding a newer version
of Tanjore's original patchset through the nvme lists already. Please
look at version 5 here (I am working on version 6 currently).

https://lore.kernel.org/linux-nvme/20240129181953.1183084-1-jallison@ciq.com/

As your work is very similar (although has some of the same problems
that people already asked me to fix in earlier versions of the code)
maybe we can collaborate on getting a unified version of this work
reviewed.

Please take a look at the link above, and see if we can merge our efforts.

Thanks !

Jeremy Allison / CIQ.
Samba Team.

