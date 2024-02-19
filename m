Return-Path: <linux-kernel+bounces-71763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F76385AA18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4943B203A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1545953;
	Mon, 19 Feb 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GU8jiLmL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAE45956
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364002; cv=none; b=TN+x6QS9ZbsPmkbSfXknWrjAZpw7aOqYG0GznuD7s7JoBuCAw+ErhBOvzEnK9S6o6VeZZpmUi6z3Tt2DhXG5oCLfnuVARgBpcPS1Tqhd+6vO6ab+rfD5mpzPqqSHyU2VWBk1/AlVG6D668vGsg06aRHuVWeJ82SIbAjAa66AYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364002; c=relaxed/simple;
	bh=6avWnawr2UKbNt3LnY1oNnBulNS03ZSo4bYwpqCzFXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lbyOpIMv69k8K6pKn3DY0b65NRMaw+RrMdo9WLihYRohOuk5xT5jun2hv9XqSZHmZrF4e/w4rqtfXw51ES1zklSMGSwrxX9gPnFUYlEngONqocvWtU5G+KDnOk2087AoQ6Bq/QCHYKvmMBHLyNhiddRb94L9inD6TSkVxIVLAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GU8jiLmL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708364000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=y70x1lk7CC3AaVnNjq3BizuyfG0wau/9LXBpqiTefe8=;
	b=GU8jiLmLdHl1cA+0PDS0VpiPcjMiyNa99yxrBUq2IFwOUmz0cJEKvL+DusCFxnlPbRj/oJ
	nAABAuTT+FzVotLf2rqAAo199NknZYPEiIKv7B6l6W8hCfNoCI2xDurohQ4OPRBoAo7gxy
	zD6IC43uVGeZgKCfmEiqj7J9nmmiLb0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-CR5oL2YbOUeSoBgzquaX7Q-1; Mon, 19 Feb 2024 12:33:16 -0500
X-MC-Unique: CR5oL2YbOUeSoBgzquaX7Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7872bf222bfso487039285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363996; x=1708968796;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y70x1lk7CC3AaVnNjq3BizuyfG0wau/9LXBpqiTefe8=;
        b=LsmkLwOOd+5MCY4imgy+p5QiBESv4Jn3RclCx5O0ICGbv3xXDHhsvSxPo0MwM8iGB3
         AoLyq3yH+Cz8kHcGiEtcbTImR2sNw0nng99kQhwB8l8EvQtSqtP0dHmhnL6oDk5DMnmP
         jgIixnnrZ16aKHZ45qQcyyMTMKnv58HSr9bFybbfnixlYTKkEw4fVRT7RUsevV9toHJb
         SgiXIzjpfShToqHhbK92NZT3cjstPLS6iOB462OlxAeRkiyhc/MNKzd7N/40a3xSCmvN
         e5k+G02hwM7q7Nm5aaDYTbmEjX2ta+F04zqhrSb12gqLsuxhLNdtOlMmcyZSDuCTsdfo
         lr0A==
X-Forwarded-Encrypted: i=1; AJvYcCXMKeTGDP0riXozEQbXIoiolAapP+ZYHLLr9ohIEyGq1DvT2GBomh+PmjFTZYQHiwX/bjc4vIUxOjU5bJojPriu4LcMopvAVyTNqDcx
X-Gm-Message-State: AOJu0YxjMLG68aRPHOke7skt2ZZKecEWxre1LRa6iOXDgZj6vFDYtCLO
	KuA6im6+VTrBaBHX0UX3XIZfq5fcYDez0fXqpFPrHwxJ7YRX5/f89xST7hXJOZ5zq5rPZF3B6wJ
	XDcThte7BuqCc7dIJ6K80kkMUyHcX/3GyQGmRZv9AkvUjHf0BOiQJQpFt5M10OA==
X-Received: by 2002:ae9:c30a:0:b0:787:6e99:a889 with SMTP id n10-20020ae9c30a000000b007876e99a889mr2048062qkg.37.1708363996011;
        Mon, 19 Feb 2024 09:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFBQjY+bgONGiwJ1rR4f9gvvW0U1G0AhkGdUJGBg6+TbNfHWaPDDjFL9uuKTQRsoigx6HeNA==
X-Received: by 2002:ae9:c30a:0:b0:787:6e99:a889 with SMTP id n10-20020ae9c30a000000b007876e99a889mr2048046qkg.37.1708363995737;
        Mon, 19 Feb 2024 09:33:15 -0800 (PST)
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a404100b00785d8a6d019sm2654149qko.12.2024.02.19.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:33:15 -0800 (PST)
Date: Mon, 19 Feb 2024 12:33:12 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Automating console_blast.sh
Message-ID: <ZdOQ2KzOIgYc8Ber@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello John,

I am investigating if we can automate, and, possibly add console_blash.sh
[1] to our test suite here at Red Hat.

At Red Hat we use SSH to manage our test boxes. On an off-list email
you wrote that 'Only the UART should be used as a console'. I took
this as no ssh session should be used from the boot up until the crash,
but I should have confirmed this. Is this correct?

The license for our test suite is GPL v3 [2]. May we have your permission to
license it under that or permissive?

Adding Bruno @ CKI to CC. 

[1] https://lore.kernel.org/linux-rt-users/ZcQjxa4UA6hzXHnU@thinkpad2021/

[2] https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/tree/main/rt-tests

Sincerely
John Wyatt


