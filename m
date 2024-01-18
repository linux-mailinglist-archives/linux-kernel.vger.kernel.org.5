Return-Path: <linux-kernel+bounces-30251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2E831C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAE21C22E10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD12577A;
	Thu, 18 Jan 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3TKXrvdF"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F4219ED
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591294; cv=none; b=hwC6WzqujnLD6Emw27aHWSSK4JMnQk0LklMMSMYL9RYlWCdqIXHDipa4FvhN7BGJKJKXzcRFNuxXGmDbOYAR8uIFi9DVlLlNTKjFgvRqVfQnuY1qhhEs8ZUSPk3G53wuXdx7ZEWMFrWNSUA/BzN1C17LvgDhPCWU/PiK6p4Hl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591294; c=relaxed/simple;
	bh=nHY2H4qZ70M06IbJgXL+mh1dOxF31u6zQs+MBaMqFF8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer; b=nnzRmRY2i/MEGvsvTp/+w7uU7KfbGM4DZ54RfsNO22z/SF4ZOL9EW/Na/wxVMbIp9hjGOWdWJ6ZTk4Prq/eNyJz82UbdrwXNj1i/BLjFvFkY9uYjtksesZiceVStM8u0pf+LTJ5wIyr+yYhFIZokMI4z8xaUxGbJUWOcuu3E8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3TKXrvdF; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-35d374bebe3so9807625ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705591292; x=1706196092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Vj406VBQBP421CwVVlFdOXwBadhTGvoDsY699rjci0=;
        b=3TKXrvdFyERzadON9o3LeYSpPx1hRH243VMQEEo8GK5NVaBYt2n4wt60jCuDra0TNA
         eG0IlV2DIP0VwtRLm7uwudM2cI8Lci+ITHT9Ajf1d55pZ81cLHDYNAcWrjpB7H+krPES
         dM8FwgFqLWcy2DlpHv//zYAVGeLtLejqQA1V3TuENzgtU5MbXfXP5a8QZqv9n6ExM4ja
         qtqP3aNyrK1uvMbDYK2buxxtherrfJ8pskAnK1iAukEGVKOnYvuX/um6JxeL5FqMfhDQ
         MTIxJ+Z255cJkxrwIUioPxLR28AvpcWei8B0Y5GZhY7yZoqbr5/QjdCotLhU9kBV46HE
         5Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591292; x=1706196092;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Vj406VBQBP421CwVVlFdOXwBadhTGvoDsY699rjci0=;
        b=DzQ8vKrJsYxmY310RjSkvaRvgssHw+AzVMOnyejSwjVdD/t241JACT4RP5Ue8cqaJL
         aCaWsbsmWFL3RqBwJ+HvBvu2ntMDfGqx3bTUz1FKqrN4A5XzvkDGOpLYYaWzM20XvBOL
         ddsYGyC9GVC0kT5J4Ivf8/ap6rR+EI1YHKNS2jXjK6xzl7ACQ9/pBdbUoyZMCYdV3cs/
         C4eKfX3vqSymTnkxFIR/AUAJyMOGWRUYZNwMKYMuQPG5w66saxYQf39Q7af8E2esBhvy
         /Z2lNXBGfBXGcA6kn3SXsiYTb5sM1CMGXZM0AzTPoy8/ia1gqoRIXx4+G/h+/hV1N/8G
         Kvcw==
X-Gm-Message-State: AOJu0YxmqHvKM3vetE9cNNpN0JF+b4RuNwfaIdwp0UYkPGfTZ01Ag3bL
	TpIX12XqhDB6hu+0HJPCWZWsIicOnL3u6Km/QRF/zPm+wgzOGLhAZ9ylhWwYAeg=
X-Google-Smtp-Source: AGHT+IFkkMB2jwGOsZvQjb8QBB5LeF/SJeIxo/NVxeAS7b9UoD+d0eANohhQtP3B1gjOGidA2wDYwg==
X-Received: by 2002:a5e:9747:0:b0:7bf:35d5:bd21 with SMTP id h7-20020a5e9747000000b007bf35d5bd21mr2142003ioq.1.1705591292064;
        Thu, 18 Jan 2024 07:21:32 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n26-20020a6b411a000000b007bf2dcd385bsm3129897ioa.5.2024.01.18.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:21:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, corbet@lwn.net, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <a86cfdc8-016f-40f1-8b58-0cb15d2a792c@arm.com>
References: <a86cfdc8-016f-40f1-8b58-0cb15d2a792c@arm.com>
Subject: Re: [PATCHv2] Documentation: block: ioprio: Update schedulers
Message-Id: <170559129037.861386.11416426652561854463.b4-ty@kernel.dk>
Date: Thu, 18 Jan 2024 08:21:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 18 Jan 2024 09:29:56 +0000, Christian Loehle wrote:
> This doc hasn't been touched in a while, in the meantime some
> new io schedulers were added (e.g. all of mq), some with ioprio
> support.
> 
> Also reword the introduction to remove reference to CFQ and the
> limitation that io priorities only work on reads, which is no longer
> true.
> 
> [...]

Applied, thanks!

[1/1] Documentation: block: ioprio: Update schedulers
      commit: b2e792ae883a0aa976d4176dfa7dc933263440ea

Best regards,
-- 
Jens Axboe




