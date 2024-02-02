Return-Path: <linux-kernel+bounces-49651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A24846D7C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31139295D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BB25B688;
	Fri,  2 Feb 2024 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hxgxT2gE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8E78B7D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868812; cv=none; b=DvcUmDsoTIF3XB9YKoM4NWkU3xVWePyTkRAZpLwof/IIREOPUgeWafjQtrUII2kxP8l7DlwPa9ZvyHqfy6NYhDhR0AQuGgcBE9BVkPSoGBjzIGRnCsHgWFVulYc4qlPsb45kviVAfuS9XdXnCgmJiadxPWzq54VpFLsY2LwxlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868812; c=relaxed/simple;
	bh=MQ9L7/GkVMpfR+uPH5ShxU1a+Sz6hvR/lvX2co5md1M=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=n5ycEObm4SY7/cEG2HoAffkPZpEgLjSgcSZfhxpplJqJdRO0+XdxS0fJxQOome8ykRURI7srKHLYVbWzvpYr2lCk5ecus6lPtFeYBgunE0A7XsGa8MqeKNavJNYi8v9VXaHQ7lLlvZuEhTZrWzj/LWOcoBvlrn3JtktlPmy0Kjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hxgxT2gE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604186a5775so22570947b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706868809; x=1707473609; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BRBtPAQkqEY6HjWGdFWpru8F8LiO7TUhaT7CNwarvZ4=;
        b=hxgxT2gE2O8TtZqAnTt2QXZtfvO7hAZdZEXQ6H1kkRoOOynDGOFXAFm5kEUNUHfuvW
         rzErUFkNyYqV3zetj1+3KEOS8ySax5YnXq7AVeNe+psp1bGNQ9YKSrFChWIzxudyfPlv
         XUHdejSiwcZP4UQJ2xMEmdSHyi6b1qIUdY7XtHaFePaB1B/upmujuEFbYPiAZDB8mBDm
         q7MMQKcBy2J8HHg1NaRL9Tyjie03DYBWbEDwl2WOFf4BsGtdyyElwXBcZKqPsrtyMPkj
         mYv54IqiKkDG41ZjF1ennzwsy8BfWyX56ohffWGOYDU6nKBKTZK9WwEkA3r1WG1PszXp
         bHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706868809; x=1707473609;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRBtPAQkqEY6HjWGdFWpru8F8LiO7TUhaT7CNwarvZ4=;
        b=QPwKZ5Q1zdNTEoLbuSCtpWsXGAL1AHp6jYyAAnfvo3RkLn/8EETiPv0vnZZG9LiJih
         uG2co9+QbIsqtLsem/OhQIN028c5ax6efqJa1pwNCpjJj+6VMKX63ld79IJll3aqqUBh
         crLLnq+8Un0UKiLnOaY322R9m6eB7mBq7W14i3AA/Zow2NX1ATWzJ3uboY2VIoNE06HG
         FUid+jwJ6NLA3Je9EjEUc1eHit9S4tmw4kMDEYb+4KGb2UJb7MqclGSgmykOzOJ/ZGyN
         8N13ZtnmCQsNviQyfwJ1rFqcohJ34C7gIQg9Cytb+/9cjPF3XB4DZGuTJ4USBZXfDB4a
         hAXg==
X-Gm-Message-State: AOJu0YyZ4nl+Zseq/vhik1OqY59TJDaF7HsIweByf1pqnqCdIVgwd4TG
	99Sb3C+GzF0dIIXAyqKVO4XYycyRgyS/6Vr0Vzr2+fmj8d19lwSoISgljjsbrzBAwkTbmDxxSYc
	f5IadykF5jI5gaw==
X-Google-Smtp-Source: AGHT+IGK0Zl6ykIWBy6opXpmg17C9xAlPobtTPHOXH7c+/rKapoXDTqpq/lUeDA9PJIcnUeVcnqR0cLyVOwCXTY=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:690c:d84:b0:604:125:f0cf with SMTP
 id da4-20020a05690c0d8400b006040125f0cfmr405440ywb.2.1706868809116; Fri, 02
 Feb 2024 02:13:29 -0800 (PST)
Date: Fri,  2 Feb 2024 02:13:23 -0800
Message-Id: <20240202101326.876070-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 0/2] Improve remote-endpoint parsing
From: Saravana Kannan <saravanak@google.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>
Cc: kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some changes to do a more accurate parsing of remote-endpoints. Making
fw_devlink a tiny bit more efficient and the debug logs a bit cleaner when
trying to debug fw_devlink.

Saravana Kannan (2):
  of: property: Improve finding the consumer of a remote-endpoint
    property
  of: property: Improve finding the supplier of a remote-endpoint
    property

 drivers/of/property.c | 71 ++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


