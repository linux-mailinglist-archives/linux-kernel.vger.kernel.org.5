Return-Path: <linux-kernel+bounces-36163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999C839CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A60B264AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A153E1D;
	Tue, 23 Jan 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loJ9QKWw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD153808
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050839; cv=none; b=UXsImUIY7eUt+aNU0Po+fTG/+YntNUKbPuP9iPCEkkM2Ge8LA1GQXa7Z/buHbsDrkKQ482FPFiHH1JnJuyWNvozHq/mKe/Bsa3DKh7Yb8+97ZsGUBVAcqlP6/+rPV5UYMxVKdh30O5gPhL8uuyThbizoWBely18q28yD8WlRbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050839; c=relaxed/simple;
	bh=1F2Qaxx0X4RH64MvPK8ltxCC/J1hBfLXSHmNUUNkRVU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oKj5vMQxq9TpquLdP/uPBHjQdUoZFP9uIioQfGnzUOYHvsPuYPF7POLqjYhrab43SWggmXr9l4zy5ien3pJaggGPVfe9kCri42PuJg2eBI+3b6Se8pfKo7+DpPKha0TKUJWLsbkObLIub848NInm9NSj3RJUxWUJF8hAHlmVJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loJ9QKWw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc26605c3aaso6037515276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706050837; x=1706655637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpBA1amDIIWdDJ6LPLULP87iPv1yXvr1GDinBnEPISQ=;
        b=loJ9QKWwx2zBLp9nBqlDQzbZaOR23nbd3vXhAT+e37NJUiVd5vonJjqHmNuQIatSzP
         PYUTVNxoVR7SvVqnlN+w+xMXul5PVgfxUTgixAKwXDYI2AuSsJeQ0JhVEzKhvYTem2qV
         ZF6UUmdY3uWBEsJZ+EeyH2Lz9EchW2ZxkfBhMWW4uQv2UX6JwUlUsvDOwFRFi+c6166/
         /y8C7GagndvuJIkaUJh8JDA6UitE41iVeOFfPsroShF50Udt2Pf4LjgbTO4YsxlYZFQQ
         hVSVLwdyFy+DSubsmTs/rd/Sqc0bMoFkJlP+Hxoh8UrDL0+lxy4r78T+fAp93RJzegSb
         ia/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706050837; x=1706655637;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpBA1amDIIWdDJ6LPLULP87iPv1yXvr1GDinBnEPISQ=;
        b=O2g+58PBOiF/cwthbSIszW9tNDlCsV2edIzBunRI9OdQ4YleovuN+2SH/yPs2crioa
         Tqou6WCJdlvSrrL0QEPxqw3NwjAd5zyDL9GJOXnitXlsv16DwEMnKy6ETUzpGIrsM2Pr
         TOpd6hZCHhocYVjPbN/fpB3MvfsSsdszqiF4FhTeoVJZA3D2MS7d6KPSSVdhmV+kXpvU
         Ch06nPkSbs0Q9KsnWOIaOa6kzGM+1lmCoK2xQxPD9ClI3ZAI19b9HDMlp57zSE28FHRQ
         g24VGSpxfqrEXxMm2obgOg7NYzIRGsL405rX8xMFPEUNnHiUHEuqEAsUV1ZJTRfSeu2y
         RrAA==
X-Gm-Message-State: AOJu0YzIVmd7uIxpcYoIPc+uob2g/K2ClvY0oUqNyHRo1ROy7T81IA8s
	hGyVBpzj436UXGsgy3Xbdh4s57wTLU5/8eGla57k2pDsLRXvqkgBMv1zaz4Lph2fXo9Fvbsfn9p
	jkw==
X-Google-Smtp-Source: AGHT+IEsUJfha+HUtxBPjbdRfDNnrDTm2iRfwj3LukExHF25a4abzM5kw8V3CYMPuPoUsetw8QW+nf8ci04=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:b1f:b0:dbe:abc7:ae5c with SMTP id
 ch31-20020a0569020b1f00b00dbeabc7ae5cmr488261ybb.3.1706050837513; Tue, 23 Jan
 2024 15:00:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Jan 2024 15:00:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123230031.2487501-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.01.24 - Memtypes for non-coherent DMA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Tomorrow's PUCK topic is memtypes for non-coherent DMA.

https://lore.kernel.org/all/20240105091237.24577-1-yan.y.zhao@intel.com

Time:     6am PDT
Video:    https://meet.google.com/vdb-aeqo-knk
Phone:    https://tel.meet/vdb-aeqo-knk?pin=3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link

Future Schedule:
January 31st - Finalizing internal guest_memfd APIs for SNP/TDX (tentative)
February     - Available!

