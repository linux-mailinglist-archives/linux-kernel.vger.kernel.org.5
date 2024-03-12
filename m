Return-Path: <linux-kernel+bounces-100384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4166B8796A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1178280F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637287C084;
	Tue, 12 Mar 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZDucpGX"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F707B3F1;
	Tue, 12 Mar 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254643; cv=none; b=XLhNx0Cq4SAJegaJnzCQ2rHBo9THjH2H3MsEuG8UD//j+CWGrc1NRVIAF94Fn0lGSRZ8fTg2POCVQfl1a9kHXO0QGK2qE7W0WQPJY9v891w4hHq/1Fj5DsKQO5aNCPbPQnjmOBI6OoR8fc6ukmPXxbK3pk4CC+ij68L7y/tfFCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254643; c=relaxed/simple;
	bh=z/OxTf//2cT75VscnuKOF0GSS9o4iFxJeomSjM8XS5U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=u43+O3aMQUwF/nOMOHrgFRiZIJrigzam1tiDoroM7aSx19OhxmawC7wWk7qy3Uvx/BL3cE0PJopmZ40scL8MGzHvU/oWanEs78jmngBd7M+imcCv8Dxgq4woxk6iDeS5krf/udm1Bjbs5wNoZHyzISEooAXLYCRADlN5NdOS1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZDucpGX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso2649369a12.2;
        Tue, 12 Mar 2024 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710254641; x=1710859441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAHAahn2gh7td0YeB8OPDUS5WS8zqe3GQf6VxksElsA=;
        b=XZDucpGXXtwwUUgAU9JO89hJnxObwv7TpEcOZXjo0AeFVB1Zhg148lhzorbLTI4bwb
         REPN8BGEtnnF1e+ZmB1R5uCioIhTHwa03TuliAIdhNIg22ltPlAQ4VKudu7MJZd0SZ7o
         zJDdPXif2uq7++91CBpoTl5xVbdj+NQUqz9jPlQqMyDP6LT5GmEdc8JlHWRGqIE24Ks2
         br5lz1A4KZcgKkFajpmOpE/4i/fkdfguw4Pu//5nLV1Yk04ZYcroVWdIK7me64qRlcQv
         nRPATEDf6UnfTLOOtHaCcTc+R2l/MOXSKe5UC/bmUGoSFOLlJlZ84Iv93kp8HIe2FYpG
         714A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254641; x=1710859441;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAHAahn2gh7td0YeB8OPDUS5WS8zqe3GQf6VxksElsA=;
        b=YH6Ryz9s/D7c4/FTiNddI76Qu7U2prH8Xr6XdOB9FrfgWUW1QxhHXBJwzibRmd3w9f
         E07Io3+urwgt7iSVhb6ZfJHYr/zA5CBMOsAIKMjH00yfZcNmQpzE/LVFd7Y3PiQnwx2n
         2cvh4qEiKAFyfkGKhf8K6mzhZRgkxdckqffSeJXzhIrxs2ktv9Cz+1FyWwszcwSZ4WVu
         Ux9E614NC7ZnAmp5McFi+/fPK4vbcV4qHko3PcLNSs8euBQvf503IGq5bwsNU+0q12UI
         BWJvmLeJQHwkMFXAD07pgLlZjeasGIEv5ZzZY0aQYzPNoCe1AkK+byJju6P5mHg2NY1C
         aMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEnzHVztC9HfdeIZdQlHAZoEmt7FFY9qUMCTe7//2yCGLQd8+rE6Pu560Q3IHwdqXPWsiOVclGifRR0r1s/xPytgnot6cMQvYPwA==
X-Gm-Message-State: AOJu0YxK/B+MJ7z93DRE9yh/mDcb+jhntLYvBm3eBe5klcxZzq3ueWO3
	Kqeu1o3gjh93gnnvrMoEf+k0oBqTILH7qd8xDczDBpz21EOifXu2RsOdfDF9ipiHo87ppntKXzJ
	KoxGqFWhoZbov4l0Ip1J2FP5vWzCQ5OTTEA==
X-Google-Smtp-Source: AGHT+IFz9rruN//Sui78rDGQ5KyyZ9SZcnXwk3yQehwwAM1KVK5RWWJl4U1cBO7fTMq/UeDeGIEK0FN8b1qNA7OgKYM=
X-Received: by 2002:a17:90b:1e09:b0:29c:5767:f684 with SMTP id
 pg9-20020a17090b1e0900b0029c5767f684mr243630pjb.4.1710254641602; Tue, 12 Mar
 2024 07:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Tue, 12 Mar 2024 09:43:50 -0500
Message-ID: <CALGdzuoubbra4xKOJcsyThdk5Y1BrAmZs==wbqjbkAgmKS39Aw@mail.gmail.com>
Subject: [drivers/scsi] Question about `st_setup`
To: Kai.Makisara@kolumbus.fi, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zijie Zhao <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Dear Linux Developers for SCSI Driver,

We are curious about the functionality of `st_setup`
(https://elixir.bootlin.com/linux/latest/source/drivers/scsi/st.c#L4102).

```
static int __init st_setup(char *str)
{
  int i, len, ints[5];
  char *stp;

  stp = get_options(str, ARRAY_SIZE(ints), ints);

  if (ints[0] > 0) {
    for (i = 0; i < ints[0] && i < ARRAY_SIZE(parms); i++)
    if (parms[i].val)
      *parms[i].val = ints[i + 1];
  }
  ...
}
```

For this function, we are trying to understand how it works but not
sure whether it would be an out-of-bound read.

The length of both `ints` and `parms` is 5 (the latterdefined at
https://elixir.bootlin.com/linux/latest/source/drivers/scsi/st.c#L125).
Thus, when `ints[0]` is 5, we could assign `ints[5]`
(out-of-bound-read) to `parms[4].val`. Based on our understanding of
the `get_options` function
(https://elixir.bootlin.com/linux/latest/source/lib/cmdline.c#L107),
it could be possible that `ints[0] == 5`, where the first element of
`ints` indicates the number of parsed options. Hence, it is possible
to do
a out-of-bound read once `debug_flag` is enabled (to pass `if
(parms[i].val)`).

Please correct us if we miss some key prerequisites for this function
or the data structure.
Thanks in advance!

Based on our understanding, the possible fix could be
```
int i, len, ints[6];
```
which allocates `len(parms) + 1` for `ints`.

Best,
Chenyuan

