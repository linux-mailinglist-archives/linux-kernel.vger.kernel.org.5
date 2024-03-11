Return-Path: <linux-kernel+bounces-99485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D207E878919
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D0DB21558
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4855E56;
	Mon, 11 Mar 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTfGdCH4"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CD5467F;
	Mon, 11 Mar 2024 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186544; cv=none; b=AW2H5irq+XdkjV05Ti2RpDPT5WVdNlqxT9FYQ+iV1zCy44PF1fK56gdV28fUbx0Zo3et+zEhHusoEzUTlzIV0NTFW9lumxVSw1zMD3VDYCytHGvBodjSCSV+54M3i7gH6wo8nxlEDunHvYNK2qXHMr/bkLKKzGRi3aqHTM5HCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186544; c=relaxed/simple;
	bh=z42cvLsMGMKyxMOm2R5aqURqk1KQo5qfG34ILC6ocFo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iFI2OBJ04bg0HPhklhQ1TMz9oS9S1tMgMQ3X/e47swxvki3IRdCnZ/UK2Yc9mr9jz68JDx2g20G2HD06DWE8jlXrXdPZZ/p619LY1MrSxa141h2H28MX7Ng4t7b8cZn7leqffqDBwJOqFYniBU6p0sq/vLePABEI/rubItDlrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTfGdCH4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29c23f53eabso526742a91.0;
        Mon, 11 Mar 2024 12:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710186542; x=1710791342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EzTmwfaFSntQTdaehiwcLGkptt+X4zDnltJsaffYEjA=;
        b=iTfGdCH42mN6elwbj+QB9SYttR3PwVcJESv0fK/4boMT9rOqwm1YMkazg22uv45U0O
         OOO/WrsNgXOZdcNtHA7t1/WKypA9Pq1auoOkeA2CaJVHk3U61KpbWo+apYw3YpTfdhpK
         YpC01Yhszuyz9Zgz27pajzVLozzVM67XTvolxFACd8nalWpUIPPYlBdBVLpM+66OlCcv
         CxhhuPsPp49FJoqruA2q4yc4MguwOt8Y3Q+idabTdf4FWr9judrj+wb+LqaPu6v7OU7m
         ztFB/AW20vX9k+rMAv643tJxE9bQNPDlwYayYi2ASnXwM9d9aZc26b6nP9qL/jzROUW2
         lKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710186542; x=1710791342;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzTmwfaFSntQTdaehiwcLGkptt+X4zDnltJsaffYEjA=;
        b=vo5xg908cTmlJ/hrS8IwmeWuKWFARkx2dBatcKRQ+d1XvnL+XgV6gcSPICxyezPfTE
         Wmr1nrbJI/cZ7roUxR7Y/mdz/YqHGs3hXDWr0zWyJ0pvjGCqDRpJHNy5fEl8HVGHGovu
         wNpZDI3Tet45WxwYA1o52V7M4gOcO6QyHgbp3YdXuAWvngamV3Yi3SfJcT9iBmCscihC
         ulcTZmC6ZUycCwIbW5x4/uxOp1VKmvxJ9Mkcvl1d466ZtcHFYk+L5cbi/lEiULltUDQm
         QZcqZQayXd5g4Fz9rNfAPVFPsk67KTwPobMxVfggAhyZlgt2oKWNP1Xqls8kmveXOGwI
         Yepg==
X-Forwarded-Encrypted: i=1; AJvYcCUA4m1X8E2qqBJnjLMW6Lqz+il6yZrMWXWgxq6KLU91UOHYcHzADsrBea+uyyUEIoi/6V8nMWKRJ4QlvO5CyWKLgxdugUoUyQeI
X-Gm-Message-State: AOJu0Ywiv5xtwoGSkBp+4YXYzs6glpyzITX2aClNU3ww+syqq3/QE5eS
	UecoM4E7fgHyWggNo/hHVC4s5WnHWiXPRqMAOdq5az7MkkraXgUSXGYqg5QGMwEZL8ja7meoBSF
	+5kqhAMNocH3DhLpwozPcafyOpA==
X-Google-Smtp-Source: AGHT+IFTG7a3zlFSXzyGWycdYmEnCok1uSP4A9iNrHnIawbLU4gv7sjpwIWFJ0ipcEJjwtArnwZtUCK04BSTO43t1aU=
X-Received: by 2002:a17:90b:3ce:b0:299:33c5:9583 with SMTP id
 go14-20020a17090b03ce00b0029933c59583mr5516694pjb.14.1710186542061; Mon, 11
 Mar 2024 12:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Mon, 11 Mar 2024 14:48:50 -0500
Message-ID: <CALGdzur-rsLbd4BcgtR9QV2=ZH8xHAVySjm2z2TT=Aog74mdPw@mail.gmail.com>
Subject: [drivers/iio] Question about `iio_gts_build_avail_time_table`
To: mazziesaccount@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000056fc64061367d5f0"

--00000000000056fc64061367d5f0
Content-Type: text/plain; charset="UTF-8"

Dear Linux Developers for IIO Driver,

We are curious about the functionality of
`iio_gts_build_avail_time_table`
(https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-gts-helper.c#L363)

```
static int iio_gts_build_avail_time_table(struct iio_gts *gts)
{
  int *times, i, j, idx = 0, *int_micro_times;

  if (!gts->num_itime)
    return 0;

  times = kcalloc(gts->num_itime, sizeof(int), GFP_KERNEL);
  if (!times)
    return -ENOMEM;

  /* Sort times from all tables to one and remove duplicates */
  for (i = gts->num_itime - 1; i >= 0; i--) {
    int new = gts->itime_table[i].time_us;

    if (times[idx] < new) {
      times[idx++] = new;
      continue;
    }

    for (j = 0; j <= idx; j++) {
      if (times[j] > new) {
        memmove(&times[j + 1], &times[j],
                                (idx - j) * sizeof(int));
        times[j] = new;
        idx++;
      }
    }
  ...
}
```

For this function, we are trying to understand how it works but not
sure how this sorting is done.

1. When the gts->itime_table[i].time_us is zero, e.g., the time
sequence is `3, 0, 1`, the inner for-loop will not terminate and do
out-of-bound writes. This is because once `times[j] > new`, the value
`new` will be added in the current position and the `times[j]` will be
moved to `j+1` position, which makes the if-condition always hold.
Meanwhile, idx will be added one, making the loop keep running without
termination and out-of-bound write.
2. If none of the gts->itime_table[i].time_us is zero, the elements
will just be copied without being sorted as described in the comment
"Sort times from all tables to one and remove duplicates".

Please correct us if we miss some key prerequisites for this function
or the data structure.
Thanks in advance!

A possible patch based on our understanding is attached.

Best,
Chenyuan

--00000000000056fc64061367d5f0
Content-Type: application/octet-stream; name="iio.patch"
Content-Disposition: attachment; filename="iio.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltncwab40>
X-Attachment-Id: f_ltncwab40

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1ndHMtaGVscGVyLmMgYi9kcml2
ZXJzL2lpby9pbmR1c3RyaWFsaW8tZ3RzLWhlbHBlci5jCmluZGV4IDc2NTMyNjFkMmRjMi4uMDY2
N2RhOTg4Mjk1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lpby9pbmR1c3RyaWFsaW8tZ3RzLWhlbHBl
ci5jCisrKyBiL2RyaXZlcnMvaWlvL2luZHVzdHJpYWxpby1ndHMtaGVscGVyLmMKQEAgLTM3NSwx
OSArMzc1LDE3IEBAIHN0YXRpYyBpbnQgaWlvX2d0c19idWlsZF9hdmFpbF90aW1lX3RhYmxlKHN0
cnVjdCBpaW9fZ3RzICpndHMpCiAJZm9yIChpID0gZ3RzLT5udW1faXRpbWUgLSAxOyBpID49IDA7
IGktLSkgewogCQlpbnQgbmV3ID0gZ3RzLT5pdGltZV90YWJsZVtpXS50aW1lX3VzOwogCi0JCWlm
ICh0aW1lc1tpZHhdIDwgbmV3KSB7Ci0JCQl0aW1lc1tpZHgrK10gPSBuZXc7Ci0JCQljb250aW51
ZTsKLQkJfQorCQl0aW1lc1tpZHhdID0gbmV3OwogCiAJCWZvciAoaiA9IDA7IGogPD0gaWR4OyBq
KyspIHsKIAkJCWlmICh0aW1lc1tqXSA+IG5ldykgewogCQkJCW1lbW1vdmUoJnRpbWVzW2ogKyAx
XSwgJnRpbWVzW2pdLAogCQkJCQkoaWR4IC0gaikgKiBzaXplb2YoaW50KSk7CiAJCQkJdGltZXNb
al0gPSBuZXc7Ci0JCQkJaWR4Kys7CisJCQkJYnJlYWs7CiAJCQl9CiAJCX0KKwkJaWR4Kys7CiAJ
fQogCiAJLyogY3JlYXRlIGEgbGlzdCBvZiB0aW1lcyBmb3JtYXR0ZWQgYXMgbGlzdCBvZiBJSU9f
VkFMX0lOVF9QTFVTX01JQ1JPICovCg==
--00000000000056fc64061367d5f0--

