Return-Path: <linux-kernel+bounces-53176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A459484A1B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599C8284901
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2543347F71;
	Mon,  5 Feb 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqGyY1OU"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5147F52
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156186; cv=none; b=s7rtEsCl/6ztS0uIPiUIp0DGZ11aS5nHema8rxkgQ0PzkGlqtzVg8j7Mdpx9Q/tPDdSe4fxVf+rlWbHjqUKx9XtYL0t4zN56BqL7+vF9VzyXn4ntPeqxX9LtWEB4YbHoZ4GzbSVTndtwbFJkXbnRhiTsqP5fFz/FVHqQmBMeyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156186; c=relaxed/simple;
	bh=OOgVZRPlSywx4rxRdVx+mq68r49uSU2xQZ5q5NB18Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2bs0TFolzkfgcD8JgM9fAd4/jGK+9NYGTxEijZhKy4i3n+aiVTIUXKt4KI50zusjKuiklYKs17ZZBaBf3F4mBqcLIauTJgvWUh+rflU4h+jiM8wa1Ts9zZn8QVWM/BBGH0/WffmrkJwzVCrkCitV1HXToHb5opXC31P+05NlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqGyY1OU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3448104b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707156184; x=1707760984; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fAEbF6lnUf3UCRJv3PsQ/b68B+NGFJMDZrCznOHMIO8=;
        b=VqGyY1OUPeP43vNeWFDz1guLYC8yCkEpica+fC0agdKfO5dY69up8aoL6M8W3fFgC0
         8zjVJhJB2FbjJfUu9OHTjS2MWt25DAMbQab6xK9SFvqxbHoX2ONZcYIKIdjFl/cHOBNe
         bWM+7phzk1A5H438XvW2DZGtuhncppzuMsySfh13KyfcPsbWOcK6DN8vfYlYDnnOk98D
         lfnd+UisJmnWmbaQTPNxsVZJYmh3zeqS8qXS+mkREXxzO5RKHbOGmeGWKjRG1HC5dedr
         gJ6tkHqu2M1t75GCnfAArE+3Uf3rsISJgUjoP0SxN62u1wUhioO4rsfeRw2ZNKssHa73
         ryMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156184; x=1707760984;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAEbF6lnUf3UCRJv3PsQ/b68B+NGFJMDZrCznOHMIO8=;
        b=tNK2zBZl4c9VUkVjIh9k824ADKiZ+JbT6VSmWjf3SJT57WXY2WJ7wNIAXDApzKFGHx
         UL/OcBzZihRjajytCYgO9VnR5t09J2CHXWK+qLjbvhdAgC9B4KMKR5fG/v3jZzqwBBsk
         g3MaqNmrmm50DeWzVii7kKs7NmDbbQIRotfBtHKGM71jwN8nnxHIXj+QsKLkmPthCvzk
         TysG3gLQh0UB/i0G8roIklHmoTbQO4KtI4wGuis/SjGFeP7KVdt4pDj+IkuBFIrsB6CG
         KI6GORKJfpcBEuGXmv68AZx2XjAqiPmLdVBjSd96QLQT4ft9Mz9+lFKgdXG1ZXR8fyOC
         qeHw==
X-Gm-Message-State: AOJu0Yz5vFjlbn82BtNEqkcJ9efhi9ITbXPZhgK8S30eMQl9PZWSYcWv
	9IQz6J2+4ALPCgyXbrsngYedFECjMzKsSMhTxkFDuQZMjvM7pnha
X-Google-Smtp-Source: AGHT+IENJCdywK0pbsFqRYMAydL/rsvOI9Bgpl/04DmuE3DOBeBv4DpHmFcV9dot2b7lfqLn3QNxLA==
X-Received: by 2002:aa7:84c6:0:b0:6e0:35e9:a78e with SMTP id x6-20020aa784c6000000b006e035e9a78emr261321pfn.21.1707156183923;
        Mon, 05 Feb 2024 10:03:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX75jwKFX0H8LHboe02efvZ8bvzkanZLydpE5+l9I+n4yS4HEAHqMjev9OUnF7NSaRd0AOiHgoBOjBXQ24QBABCg/tpo+uZ7GRf7I0ZWgEvF4N8LeDcJoxBggO4bZw=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a63e004000000b005dc1d18c0c6sm299988pgh.11.2024.02.05.10.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:03:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 5 Feb 2024 10:03:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Spurious problems when running regmap unit tests in qemu
Message-ID: <fc1d865d-3e2e-48bc-8cd1-389ec6b15909@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am observing spurious regmap unit test failures in my qemu test runs.
Examples:

  # raw_noinc_write: ASSERTION FAILED at drivers/base/regmap/regmap-kunit.c:1243
  Expected val_test == val, but
      val_test == 65581 (0x1002d)
      val == 45 (0x2d)
      not ok 8 maple-big
  # raw_noinc_write: pass:7 fail:1 skip:0 total:8

  or

  # raw_noinc_write: ASSERTION FAILED at drivers/base/regmap/regmap-kunit.c:1243
  Expected val_test == val, but
      val_test == 65556 (0x10014)
      val == 20 (0x14)
      not ok 5 rbtree-little
      ok 6 rbtree-big
      ok 7 maple-little
      ok 8 maple-big
  # raw_noinc_write: pass:7 fail:1 skip:0 total:8

The problem is not seen all the time. I see it with various qemu machines,
but not always the same. Endianness does not seem to make a difference.
The failure is always in raw_noinc_write. So far, I have observed the
following individual test failures:

not ok 2 none-big
not ok 4 flat-big
not ok 5 rbtree-little
not ok 8 maple-big

The most recent test run (on v6.8-rc3) failed on the following
architectures and machines (again, those are not always the same).

arm:npcm750-evb:regmap
mips:malta:regmap
mipsel64:malta:regmap
i386:q35:regmap

I only recently started to track unit test failures, so I don't know yet
if this problem has been introduced recently or if it has existed since
the tests were introduced.

Any idea how to debug this problem would be welcome. I'll try to bisect,
but of course that will only help if the problem was introduced recently.

Thanks,
Guenter

