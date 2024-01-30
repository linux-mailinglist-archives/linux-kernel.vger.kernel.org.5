Return-Path: <linux-kernel+bounces-45005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C67842A40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84565B25F80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDBA128368;
	Tue, 30 Jan 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="SOe+KHLc"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767E1E4A1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634130; cv=none; b=lRXXilXeox0CiLxY6vXVyhZYGejfgoYfNI844rNnbZkDPajTuCKTRpy0u3RP9IHHJdTdyKlXgJdzvlA8GGCr8E96U6nH0+Fu58Ae/vnfsPwiiW58fKCOJTcjKoekqRF47nGj2v/hpM82hHdxaEVm/F6+sLOUa6alLn+XQ6MhCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634130; c=relaxed/simple;
	bh=UdAWFMhVWskyEezYlWIXrrfz1aIEFDkRzDWmsPFUZaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzHtrAAfeGN4jH5iNApPE+VEshNtMNZUCbyvB6qdPetZ+mMD9lhxABPDRAIlzfOOGo5jfy9MlIdXipq+OdkBrMno/HoNYwMAcJkKb4upfwEE2wu10cFARDWg3MNNy3/BjvgEXwqyDVWUsHc6Z7vT7E2qWbScuDm42iJkMO42NaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=SOe+KHLc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2069132a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706634129; x=1707238929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UdAWFMhVWskyEezYlWIXrrfz1aIEFDkRzDWmsPFUZaw=;
        b=SOe+KHLc9s+nV30oXVvGcgyUgEU6fEU6EzxntnbJTE+nl3Uc/MEA1EWM22hQoauDXD
         CSlufKASAnZoR5j/LkOtZnceRpnb2A6gdCF47GV3bwv39nFGkynYnDJcNlixyDrCz10Z
         +7YuwOfoZifwJ5aqxP/tqWmoFFa1qRt41fYyWOTIUBrUtJuHcuaxodAY+dhM8aMd12q8
         nIOhBt2SXFfMv+yAuqh4zqnN5owkhsYtSOffyIiMo4n+aZGMVRO80wcMb+k0rJrTZ1y+
         buQx2J65TqYjjXw7eBcvN9RfYWfVSQNMvBLKw8I6zPQTlj5z+SvvhUT6sO33MxVQiXs4
         uq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634129; x=1707238929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdAWFMhVWskyEezYlWIXrrfz1aIEFDkRzDWmsPFUZaw=;
        b=pUxxo6NkwT9l38pq5mwk0/tMDmL/O28PuLHPjAEpT+SAyL+Bq1llndEjlgss1Z9C38
         Y4Txx9G7oDtR1dv42gOyCUjSA+QPhKMT1E0SkwGHw02h2BDgzrA6Lvfzpx7mzDqq9K0m
         wsQBEa4i/D3ZPlYz4CKQZxvtYGYJrm4kPlrjtKzgYclr/OAXtIJQH4bSxI71C8D94p9i
         Sdpp4bVxCsRcKJUwsRZUDZ32EUpU1shreMYaQ9Nne7pyzOhKlftHVmuAKx+yCYET0omq
         PrXKWzJ6buKevDdR3VU0+FIg5oBQ25nRNKKWHBGxqa0DGwZpD5snMZ/4O8UtRZ5HuSqf
         SBkA==
X-Gm-Message-State: AOJu0YwRbfT2HiCdoK7JWAeSrZi9XvJRX2JS6GqtvVNKC2twkR6V7Ljg
	HW0EXZq8MtcDA9vDye2WpNmasxlkXJWHvZJHAgj4loHQFd0jAR36e+Aag/mLudGlowxvUgXm+yi
	81HRr3NLRORyH5M76fwa0WcantUIzmDiWv7iafQ==
X-Google-Smtp-Source: AGHT+IFOy96TCjteG0UAX6AIpinpu4X7+FOvTpBQjGrkV3nrUYd7/KbDXfEpg9DrREVncBZI0eO5ZXbjKT7VIM62Kjk=
X-Received: by 2002:a05:6a20:d703:b0:19c:b1f0:9842 with SMTP id
 iz3-20020a056a20d70300b0019cb1f09842mr4453505pzb.8.1706634128647; Tue, 30 Jan
 2024 09:02:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130152903.3651341-1-naresh.solanki@9elements.com> <6aa79b06-ab59-4f4b-96c4-bdfb03974aec@roeck-us.net>
In-Reply-To: <6aa79b06-ab59-4f4b-96c4-bdfb03974aec@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 30 Jan 2024 22:31:58 +0530
Message-ID: <CABqG17ghoF0UMU4m=+tQtSncgZUJ7fdk04cjHN4r-x=RwiAWbQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus_core) Allow to hook PMBUS_SMBALERT_MASK
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, mazziesaccount@gmail.com, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Tue, 30 Jan 2024 at 22:01, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Jan 30, 2024 at 08:59:03PM +0530, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Use _pmbus_write_word_data to allow intercepting writes to
> > PMBUS_SMBALERT_MASK in the custom chip specific code.
> >
> > This is required for MP2971/MP2973 which doesn't follow the
> > PMBUS specification for PMBUS_SMBALERT_MASK.
>
> Applied, but is there going to be a follow-up patch for those chips ?
Yes.

Regards,
Naresh
>
> Thanks,
> Guenter

