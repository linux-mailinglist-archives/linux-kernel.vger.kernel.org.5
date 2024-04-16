Return-Path: <linux-kernel+bounces-146341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E14A8A63AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18106B24D49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23D4207A;
	Tue, 16 Apr 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="MLcaWDqm"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284B3C6A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248323; cv=none; b=DKeP6DcPNv74WzwODAhN6/Wn43C3wjbg+67XDEu+fQyjUzy2KPnwC6Pmk29lSyxY2T5TIPAVMcJ35hYwnhvZElRt3HSml3w3DYfMVQDcEA+b6sz4QIjwyYzEvah1H0j7q5koOwiC0yDn6Q9ZvS5ASoPL64gwlhD+3SVVrMMHDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248323; c=relaxed/simple;
	bh=fKPti6GPVpVzlACAJ9Y0pbD+Ci+HzVHMAZ9cl1ew3wg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i8pIWadB9WryiTq3BFRjpsoI+4B+xTfUc83if1Qq8EwJQsBivh273gT5MM2F0pcgSZkBnZGafrw1wQCPhpOUc0Uf7a5QOGhx111tek04dnsFIQ1v0HWwGPTMvPpzWf2Til+PrfXFLziF4evx4ChaN52b2U7+fjCyS+ekPUJJ3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=MLcaWDqm; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2da08b06e0dso42773981fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1713248320; x=1713853120; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKPti6GPVpVzlACAJ9Y0pbD+Ci+HzVHMAZ9cl1ew3wg=;
        b=MLcaWDqmcPMCubw8WI8I2vpECjmumRy431Ddg4CKQibb4LF1glwoDjtypTZFc1sZC+
         3QHKlJSeyH2MYH6xFMgDFktRhfFK11PwlvjLNEtgGFhe6VVyhDs9p+AEnlD2MV10E6LC
         afrBmg/HdjfWE/d3FG0rs2H8L41v3gvjWg0wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248320; x=1713853120;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKPti6GPVpVzlACAJ9Y0pbD+Ci+HzVHMAZ9cl1ew3wg=;
        b=seGt1HkX531amNUSpv0uG2xq5mjfscVIJ60VbZVJ3pG1n43HMPv1S5uQosWZjdh2WH
         NyLTicf+k5PlxDNxR210z3A+CtDNK+Z4R/qOJfSLd4NB18g7a7YMs9o3xPnEOeyXiqKv
         igdzA7CB70Txfa2EdA12FZVFDh+wkW/Zy6qpZ49Pz3kfMKmsBV+xZicZttTg8iy1fm4s
         +6fBlLYjCS6ipzh4KY3tFq9pTyb1IrGSrDD7DNRGoBHYA1ff19VVKfnzvAiTrflRrAmA
         z/bDFaclDPzFE6VXXeAK5Xu8g559ZpRTCqPBOdDcjNaA++aQmUaKWthMJp1deE1++5Lt
         qWwQ==
X-Gm-Message-State: AOJu0YxvHwlHORcWZMOGLsohd8UBfh9aJ5SobEv9clT+wN27PnSGUcgA
	ZV1PV8xkGXL8c98aaGJxX2ur79fhWPKXjuynskUXYiXmmhCKaBk7fK/92r/lhSXcF2LF5NcgT5O
	oQa5MFHeUMLTH7vpBg7/61FBQ7i8OHV87mEGX
X-Google-Smtp-Source: AGHT+IFJh7g4I3I0sjLVraq03vMv3gw2zm10oec4UjI57XgUS3OYS6TXzmDQ82d6LshJM4uovzjODes+Z5nPbH9SDDo=
X-Received: by 2002:a2e:a99e:0:b0:2d8:270f:9764 with SMTP id
 x30-20020a2ea99e000000b002d8270f9764mr9411912ljq.40.1713248319975; Mon, 15
 Apr 2024 23:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Igor Raits <igor@gooddata.com>
Date: Tue, 16 Apr 2024 08:18:28 +0200
Message-ID: <CA+9S74jmWiSWaGoMU9AZnJJd1Ck2qNBdkBZG1=J3PC8gsqqWxg@mail.gmail.com>
Subject: Re: 6.8 to 6.9.0-rc3: kernel NULL pointer dereference in pick_next_task_fair+0x89
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, slyich@gmail.com, 
	wuyun.abel@bytedance.com, yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello all,

We also see this issue quite frequently these days, however it gets
slightly hidden behind printk issue so that full stacktrace can't be
printed due to the deadlock.

If you will have any patch to try out we are happy to test.

