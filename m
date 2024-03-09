Return-Path: <linux-kernel+bounces-97875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785DA877108
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6781F21664
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAEA39FC5;
	Sat,  9 Mar 2024 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEfRE17A"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170A28E22;
	Sat,  9 Mar 2024 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709986961; cv=none; b=ErLeAu/N3jW3oMTW6TlDbyznaOeofWx89vsvfRvyYStStj5opyS6aQ6KhGyYzinVyWNmuuUYfZCCKSQz6o60fEdtaqzhqbOot/wk8OHHXwyDc0I/6diTuCNWeZqj2Mzsi29StiPqGWz0zIEMXYpGUlucfrdltDAd9on99mZ2XHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709986961; c=relaxed/simple;
	bh=oNYQwGlIdWa98UCMqvaJ9MllMewccvT4qth27BxGmc8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=pRM6GiyUWPhiLGLrXYSZw8Gm38zIyHIeWt7Zhb9IGr21hZNF4n48EvJnJ7l11NA8KD5+WmsIacFPhEZ5eQOyK4FV0iaoAWwhl/21eGYkNVoNun+aDCIFulkpRVYB9rrMLQOM5zshIY4DRVlJ5tFgUzVTKtbNaNfgOczIadnfDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEfRE17A; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2399311a12.2;
        Sat, 09 Mar 2024 04:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709986958; x=1710591758; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNYQwGlIdWa98UCMqvaJ9MllMewccvT4qth27BxGmc8=;
        b=nEfRE17AaH8f/rbJn34eXM6QPerrL0LzSZAd1IwJ9tdNzf2p7FeAXLOXbKwRbGl37j
         rj1CeR3jBw2OYqKXG5TkhMS3CosoOEa8oUZU4K4isUGtcFN58qBBne/t7WU0iZXjs6fN
         5Fi56fk6OLL0J31ZK8kTTbueIFibQrBTizgW+B1FGlQc8PG1zP8o+S1WtMIZ2BacNXws
         OWMz2taqGReFrc4AMmwlnBTjEcJE1fy7N/rcC4w8gD6bloSpnNJqWHCTjqIugtkvxDeF
         aL6MwuYbrAE3op1h9YrBCVDEAn7KOe+iiBK7pcGkIpFkY5RjLbKSsaJcLzPx30I5GqLo
         MFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709986958; x=1710591758;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNYQwGlIdWa98UCMqvaJ9MllMewccvT4qth27BxGmc8=;
        b=jC9NQAr1iUZXTxfCMYiWrUSg9JDDeQmvXLKzItVMEbBOFglWj9e8csH2ZKdPZuhoQN
         b3eeZEw/Qy8fvFK1ZaF6T/QVaIU8fZiAuMsO8Z0hMbNaywmZ0t3zGBNGjNfNsTHROf5T
         xjR3k/3UluHWl+ZoJ8htcScBVhOfP9v7PWXD3pZeaQ1K1z5PV3ru+aq/vF9YqVX6Wlr1
         C6iIiA97HvDcWfUqy49eOVIbPk9yLycx0QFqUb1Dg8f0lVpo6W3nGDDdB4KTYmelvlvk
         18VGMUtIYt1Aq+fECMMQZSGlEFE7xu6CtHhBl0mbLH6UNY/TpehbG2Mn5W9Y3i4ZsJj3
         YpRA==
X-Forwarded-Encrypted: i=1; AJvYcCVaxZpbPlEW5EgBn9I/Zjo+aStyxyndcDBtQLYYI+mCO/yY05hMtaU32qjq6rpINbjJ7W/pA5VsdjRJ4YXZ56yBBywwOavmJAs2nbch
X-Gm-Message-State: AOJu0YxJELJaIcxWZyGc14tXawrq+CfQSlmKiQxeXazb8so4LDhkH+ZL
	aIXQhvZ69Q57UcYE+jlAJQwdhDOttuXKY36RDHN2XDbJpeEjFHcc
X-Google-Smtp-Source: AGHT+IEUca7ZcqUqXbHOOt6OjhcKZUpFwfipvJ+J2TU1ZrnLvzJnR8M3xcXsMwDVV/HR5pSgB8qRzQ==
X-Received: by 2002:a50:f686:0:b0:568:260b:e502 with SMTP id d6-20020a50f686000000b00568260be502mr1262150edn.13.1709986957633;
        Sat, 09 Mar 2024 04:22:37 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:3599:7594:d284:9242? (2a02-8389-41cf-e200-3599-7594-d284-9242.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3599:7594:d284:9242])
        by smtp.gmail.com with ESMTPSA id es20-20020a056402381400b005667b411c38sm810293edb.65.2024.03.09.04.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 04:22:37 -0800 (PST)
Message-ID: <1ee8fc6f-5299-4ba5-bb61-14b4351c0708@gmail.com>
Date: Sat, 9 Mar 2024 13:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: trivial-devices with vdd-supply: true
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I am trying to figure out the current policy to add trivial devices
(I2C/SPI devices with at most one interrupt) to trivial-devices.yaml or
include a dedicated file.

Apparently, bindings for the same sort of devices where "vdd-supply" is
provided require their own file, and I wonder why there is no
"vdd/supplied/whatever-trivial-devices.yaml".

Instead, files with trivial bindings + "vdd-supply: true" are added on a
regular basis. That property is not saying anything specific about the
device beyond that it needs a supply, which is very common. Is that
intended and no more generic bindings are desired?

On the other hand, trivial-devices.yaml includes several devices that do
require a single supply (e.g. several sensors), but it is not explicitly
documented. Did the requirement of providing vdd-supply arise after
those devices were added to trivial-devices? I think that some devices
that were added to trivial-devices in the last months could have also
had a vdd-supply property, so I am not sure about the rules to choose
one way or another.

Thanks and best regards,
Javier Carrasco

