Return-Path: <linux-kernel+bounces-128592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED2F895CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6981C21AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33E15B962;
	Tue,  2 Apr 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="doFtRcng"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C515CD5D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086625; cv=none; b=Urj/wjTBrXOZxJBPel1/EK0AFgTWcaNVtxSZcHJ7ubfMbBwTbzWF13BG/D72DYuH87mj4gyeYSFjwQBeTE9Jl/gfXlHFUi+2Y6gcoybno4RT9sqQmlYmEG9zRK9I9gV1MDgn33ntYX7hwxFLNpZnk0T72sC0dggyEJR5/nC81o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086625; c=relaxed/simple;
	bh=Ajif/9j7M/zsqMVNXdBm2tkQBVeG6jrR2PglV/6xi7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jk/WkEBsIRE1v/PBraVr8t4u8Sv4qZAXF5wMNeUQArA5CC1hUCjT54LSuEKs5gzbSOBgPf2LpOHHNLuk5kKoapLRXm/hQpcyn6phhLMlxdluiVkPuLfiuLQSaHNQRUIlDDurvo19wCZGTZKY6Oqtj++eONCD4HRrnEubc05C2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=doFtRcng; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso34068439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712086622; x=1712691422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffbeIo6yT2gnuWj86yFH3HoV79Ov5Gn0g1nar2qmPdk=;
        b=doFtRcng8oTWK4yn9UwrGli5ObSWYplTcOTOMP59wx1LzGy0Rz3yB2p35J8WIdbBQa
         ENhXwMHtoZr6aJf0V5iP/F/ztlZGqj9MrRcTSpyOoytd6oH8OA9uhui1dSZ42sPR1AN3
         iSr25HYnmF2lj39ksGldqWNPjyWJmfFYfoasOSZ1jrdnRXOMzhZrvS+SRh4TMgeTBWO9
         kQmmXFpV7IfZYutKwXl4MLtFsz6I4Z6+Exey+bLz1T4PEXSubKFrpQfooX1M0qAPAaSN
         5i0N5mDrgIGRP6N3rzKl+X6kmnks/DbR2SJFeHss64H/aepkW1Wo1x1ed8u5zS7O8mNh
         qpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086622; x=1712691422;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbeIo6yT2gnuWj86yFH3HoV79Ov5Gn0g1nar2qmPdk=;
        b=YdeiT0sQ53d8oSIDMtK8Tfv8zaQ6hUFPa/gMAzoZ7PyVGzFZpV1UDUSxgIRixMZjdR
         bkU+ekjWQJRmw6GtW9kLbqHokxmRGalnDpzbo+/zR0ivy0sTxq3DcL5ms4pp7vlOI2Ax
         bY+rRNgU+69xueLVrisyEFYsV9rWWmV4n5SzvzfEwRZNlTSgMc3Se9vthB0hbfr2YPt/
         vhTuBSLje7y/vQiv2bhNNmicjd591H2L/T3tJVGJDUrFG9NuVXvvevdJBBzsBAQMYaZa
         7AgxrIaDJO1h7FfuP1gZtSg3uK/Bp3R1VBdXWDV4CchGnV62QUWrsyCQo9opELDMI0+m
         psaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQH/CBUis3xgWhY5kev3Wekkgiw5F5++1t1NbXZv24ofnFd9OQiafDdtmbuVbO46JkUhC5lf+cFJXzUFUXiVdNEXxXpl0j9WWr0sGH
X-Gm-Message-State: AOJu0YyCqZwEt4AhYtFUxkUTg7FFHLwAw1uqPywVGcvNuL6CPYJXvwGz
	mhmyK+9DqhfaMHXnjwz+A7Taf3z7kJRyVdQj3wMWnbtFEAaOlcyzASnBtevie51YTj8Y0PNGaof
	O
X-Google-Smtp-Source: AGHT+IGlZji5c+voS0iWi3tL6QWEFiSfH4FfzhrhAh/F/fIWxonP9cijm1OoH4nm8mwagUEKj9TIrw==
X-Received: by 2002:a92:dccd:0:b0:368:80b8:36fa with SMTP id b13-20020a92dccd000000b0036880b836famr10857144ilr.2.1712086621861;
        Tue, 02 Apr 2024 12:37:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d8c5000000b003688003d036sm291713ilo.61.2024.04.02.12.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:37:01 -0700 (PDT)
Message-ID: <eefce877-ce0e-45e6-b877-a1579c5833b0@kernel.dk>
Date: Tue, 2 Apr 2024 13:37:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] kernel BUG in __io_remove_buffers
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>,
 syzbot <syzbot+beb5226eef6218124e9d@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000f3f1ef061520cb6e@google.com>
 <6816efda-dc85-4625-a396-1fa6c523db2e@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6816efda-dc85-4625-a396-1fa6c523db2e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.dk/linux.git for-6.10/io_uring

-- 
Jens Axboe


