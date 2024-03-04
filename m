Return-Path: <linux-kernel+bounces-90925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299FC8706DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFCE1C21A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A54D9FB;
	Mon,  4 Mar 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grafana.com header.i=@grafana.com header.b="OnJ4HcBA"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44D2BB10
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569115; cv=none; b=PUO2NNbWfSSDsHQYoioTbK/tlBDcaxAq/RNRfx//XcVZZ1PoayI30vPyFbdtrAfFACmeOsBMCzro9sgFWP2rB2dLkI87W9pcR+lkBoAQupbo4MQGG1czEaWCMARbIUGbkIbviDDsDen+R/PMeYZRBAJFxYfDGfu3dQeZIb0U8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569115; c=relaxed/simple;
	bh=ZbJhH0cIOHWZx985A1ZrGxPd8Yt6x1Ar75tOj2VwPcQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=URNO8tDKaFPJySHAfS1iWIEpK15vsWzeOZHVEWNAZDOGnhqTyn/62KAFX3YcaR0AZNCCfJdHEBuo3o8h4dNU3XMxcCqYb5+G+uFvEj9oiVzI5pBLUTs1K+ZR9Sl1zrm/R8drel28eBJ3D/P+Y/N5wR7SKL0qdLyZ2QKb82oAC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grafana.com; spf=pass smtp.mailfrom=grafana.com; dkim=pass (2048-bit key) header.d=grafana.com header.i=@grafana.com header.b=OnJ4HcBA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grafana.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grafana.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7882b1e87c4so32374485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grafana.com; s=g1; t=1709569112; x=1710173912; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nMYei6cwPBldq4tz/10wzBjzKgSpXduuqAEx/EcouCQ=;
        b=OnJ4HcBABDVxCJNZybAh+viSlLqaAfK7trQW02sD8yT6HTLW+mrnci+2qmggK4dXXf
         FD+VG38XVxTT0UqImkcSkGxaOow06iOvYIEibbm3q3WpftOdVTKKg82X7SqPQEv5XVde
         Z8MitVPPQk/9TFMqvKKuvKhxHM8OPlYUwQ7cgu/at+pvTpwuZehxfLFlXc4URnG2jGR9
         8UV7NeYyUITdU41c48Q8hv6R+oy8kVRlmkm7VcvzhfK+NWDFzvSpW0bv7Y4byn0eee89
         K4Kry51T6+OTWE/HmFiLy8D9wQtyjJIUqh8/jpzB/JqfFRxweLxQapy7KYln6AWXm2bu
         wVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569112; x=1710173912;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMYei6cwPBldq4tz/10wzBjzKgSpXduuqAEx/EcouCQ=;
        b=sO00dUlvwad0JnZc6epbw8t37IF66Zs4SGrbk/KNDKcjpgHufFVyFIYFgz5Qu2iwaz
         dvKze8Qtiaehp+4oHBstB36z1K0cwvQNFiN0uIHsrYflSQRyzDdvTSvrkjxb198Vu6UK
         +N/NvpJH+EO8Z6vjohRji4itB7AuyEGCAbc59gDGlbHMLBsLkISK7xATiSFsLVTYjLOh
         uvOY+yXOsM9btSRZ71L7sfmhWigu0ZReFl0TjrddHctZiCI8UOG0vcD+yko1L4kw95mt
         LeGdwC0QdPvHQWazqnjbw7xeaWpcrgyxvlYQHkfFNgzed48UEskL9xV9wr4C40x795E7
         lVtw==
X-Gm-Message-State: AOJu0YyNRLP77S+AWqnaMxYs/RCpJJcg7CnwIs3jzUM2cZPwzczt/Xzz
	3hWAIggO2X+mJ1EJQbnRtGTRijPuhuT9yyr6MVhE6W9UgCtC7JhIBoZ3tg9JBnVE0iBbtIRLdTL
	o9a4V3UZml3j30EIjAtEMJLxOBkcmC2rX+89Af2ZiRmbx7C+DqNY=
X-Google-Smtp-Source: AGHT+IEsPeBzxTc97M3ecA3y8OVM0K9+uS7CxP8H0/MBCZ/Bl19EsWVc4Waoaa32r2/HOI7RSv8p6zje5JU70UKCRic=
X-Received: by 2002:a05:6214:b84:b0:690:74bc:f88d with SMTP id
 fe4-20020a0562140b8400b0069074bcf88dmr2976464qvb.36.1709569112317; Mon, 04
 Mar 2024 08:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikola Grcevski <nikola.grcevski@grafana.com>
Date: Mon, 4 Mar 2024 11:18:21 -0500
Message-ID: <CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com>
Subject: [BPF] Unlocking the bpf_probe_write_user helper in controlled scenarios?
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since this kernel commit
https://github.com/torvalds/linux/commit/51e1bb9eeaf7868db56e58f47848e364ab4c4129,
the bpf_probe_write_user helper is locked down and cannot be used when
the kernel is set in integrity or security mode. We have a use case
for this helper for BPF enabled automatic context propagation of
OpenTelemetry trace headers (OpenTelemetry Go Auto Instrumentation and
Grafana Beyla). We write the W3C Trace Context header in outgoing HTTP
requests, by using uprobes attached to language specific HTTP/gRPC
libraries.

Writing the headers might be possible sometimes with the use of
bpf_skb_store_bytes helper, however it's not possible to be done when
TLS is enabled and it becomes very hard when the data is hpack encoded
(e.g. gRPC/HTTP2).

I'm asking if it's possible to reconsider unlocking this helper and if
it's not possible to be fully unlocked, can we unlock it for more
limited use? For example, allowed only in uprobes or only if certain
things (like memory range or PIDs) are specified though a BPF LSM
policy?

Currently when this helper is loaded by the BPF verifier, the lockdown
is checked in this order, so it seems we can only further restrict the
use by a LSM policy:

security_locked_down() {
   lockdown_is_locked_down();
   bpf_lsm_locked_down();
 }

Thanks!

