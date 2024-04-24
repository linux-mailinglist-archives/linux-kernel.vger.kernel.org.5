Return-Path: <linux-kernel+bounces-157833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AC68B16FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F8DB2760B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7216F0DD;
	Wed, 24 Apr 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qBLMYbIM"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96716EC1C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000795; cv=none; b=bZkB/sZWJaJs5TSS1VDUJaT2+7ID6HqFK5PN91kQFDNx0HXegMhD9EyiYKOORoS2aXbp2Mlv3d9Is40eV44djelX5cW8Pnbmb8t0KaIpMaheEHiUyFigixdE2wfiP+Qipz2DjPklM6oNhPptwZw2tfa4hpO5ID/HOr9wEDKKO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000795; c=relaxed/simple;
	bh=z4ViiZLxdy4jCZuWPQrDKXZVk0No4/qeBTQCDlNgGvQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pxzd5jnmK1fY0S6q0Oh0Q32noYuNYvRnhucFyOdcbEgowSmDanEkG+wVz6xyXxPa23Q7pC6pwwoZJ18DST+SjTht0yXI8hvTPfFKnRYE38N2e7IULOTDvFdlmzG01DZgIFQrSfe8/BBrjZsuVQDsQ9svV+2Eu9fi0QPNg++EwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qBLMYbIM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3c9300c65so3424785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714000792; x=1714605592; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUTRfOJXq9toeuTA94eYM/KVw4rlaWe4u/+EWKtDEug=;
        b=qBLMYbIMnIgOi/RtSlLiyEuaSN27DHEDMv+dnOyra2GH2ZpNDqxON+4Khga8LZ1oEq
         R+40X9Peh9P6mzDQO9/bGKCf0rGAIP6U79U1YqBJ56KWYa7qe7jC41T0dRxPN4JlTpiT
         m1aMbs9QRt5kEruUTQ9sGUMIPQ4+0U9Y16OSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000792; x=1714605592;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUTRfOJXq9toeuTA94eYM/KVw4rlaWe4u/+EWKtDEug=;
        b=vIvOCAa5cftZMpv3a234TOo5RSXZmebaCuqt3oiCHyYVQZO4oGUmsA+nNBdGaNsUnV
         uNc3dpMFsputu2PM1+hDOJ5zNTgTynesrwyuWY1FByopSZGwnZz485MkNxTeSZOO9AjX
         kSMfdMncVNvQLqbtiaTnDZYd0t4Vm3ocSzx1QvFMO+PAHvhFf3BU9ouYhbLgqqhb4QLC
         3BpIpi9voq2aps7HbMrY45o/gCOMtb+tvoU+6G404N4loamIIKYhDEhU+eh2aef7UUVc
         nJ8bMxFwbs/rv4N35WWcP6yiyWiq5IXrHyNOlvySusfOBP63KN/5ybqNOED1q2Y7oF+L
         DSkw==
X-Gm-Message-State: AOJu0YwLlz/kpVhkQkFO0ERM3XbW6HRoUJjZ3/igiNvW1Ej7Qu1wiX77
	vIQV8bDB5j84BsOwZCdAhCVes7253EjWdev10ZQWBm1GWJfH1qF6PmuUDiBpSEXgfMtNTdzYRBi
	jNvSvVxANn0799B1mm3GSvXRjrOO42Y4zyz84rkYqrf06vIHvjPknpau2GJaS9eMP61Ec5QQocg
	umNp+T5AhQ8D4rTz/jOc5dwmmBP7sXDLNGT4AWkGfsSy3MBQ==
X-Google-Smtp-Source: AGHT+IFkRA0EgSkYjbg6bSMkqdrLpRXRjpOUupwLvqO6F0KMMqDuOjofX2sPeF9mvRaeqlL+TXudrA==
X-Received: by 2002:a17:902:d481:b0:1e8:d85a:970 with SMTP id c1-20020a170902d48100b001e8d85a0970mr5004577plg.10.1714000792243;
        Wed, 24 Apr 2024 16:19:52 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b001dd2bacf30asm12539301plg.162.2024.04.24.16.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:19:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:19:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, shuah@kernel.org
Subject: ynl: maybe minor bug?
Message-ID: <ZimTlf_ISC2n8snQ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi there:

I am probably just doing something wrong, but I tried to run
tools/testing/selftests/drivers/net/stats.py today and hit what is possibly
a bug?

Background info: Python 3.12.3

I'm using net-next at commit 9dd15d5088e9 ("Merge branch
'sparx5-port-mirroring'") with a couple driver modifications added on top
of it that don't seem relevant to the two test failures I'm hitting:

1. "loopback has no stats", and
2. "Try to get stats for lowest unused ifindex but not 0"

Both of these tests expect the ynl library to raise an exception, but I
don't think it does, from tools/net/ynl/lib/ynl.py, the _ops method:

  if nl_msg.error:
      raise NlError(nl_msg)
  if nl_msg.done:
      if nl_msg.extack:
          print("Netlink warning:")
          print(nl_msg)

And the code in net/core/netdev-genl.c seems to set:

 else {
        NL_SET_BAD_ATTR(info->extack,
                        info->attrs[NETDEV_A_QSTATS_IFINDEX]);
        err = netdev ? -EOPNOTSUPP : -ENODEV;

which is what cli.py says:

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"ifindex": "1"}'
Netlink warning:
nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
	extack: {'bad-attr': '.ifindex'}
[]

that seems to be the warning print out from the above
tools/net/ynl/lib/ynl.py snippet, not an NlError, which is what you'd get
if you tried ifindex 0 (which is listed as out of range in the YAML spec):

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"ifindex": "0"}'

Netlink error: Numerical result out of range
nl_len = 108 (92) nl_flags = 0x300 nl_type = 2
	error: -34
        extack: {'msg': 'integer out of range', 'policy': {'min-value': 1,
        'max-value': 4294967295, 'type': 'u32'}, 'bad-attr': '.ifindex'}

I'm not sure whether:

1. tools/net/ynl/lib/ynl.py should be raising NlError when there is an
   extack in this case (I think this is probably the way to go?), or

2. the tests should be changed so that they don't expect an exception to be
   raised but (ideally?) hide the warning report from tools/net/ynl/lib/ynl.py
   when the warning is expected.

I don't know python at all so this is definitely wrong, but here's a small
change I made to fix the test (a similar change was made for the test which
follows).

The following patch is not intended to be seriously considered for
application, just to highlight the issue I am hitting:

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index 7a7b16b180e2..d9f5d1f3ed34 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -115,9 +115,8 @@ def qstat_by_ifindex(cfg) -> None:
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')

     # loopback has no stats
-    with ksft_raises(NlError) as cm:
-        netfam.qstats_get({"ifindex": 1}, dump=True)
-    ksft_eq(cm.exception.nl_msg.error, -95)
+    stats = netfam.qstats_get({"ifindex": 1}, dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -34)
     ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')



Thanks,
Joe

