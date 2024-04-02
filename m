Return-Path: <linux-kernel+bounces-128591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42144895CCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703351C22BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19315B98A;
	Tue,  2 Apr 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Kfj3SS09"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7B15B987
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086615; cv=none; b=B1qEPavnik+ToWDu/05PpNlGnRZq4Ed0pEb8GI5u4lNhkGjRBrj6jxnrNAS1AghX3Qz8qbcWkT0Rw7ALNczMog+/f3fU75B3r1bpIPBQGBJpeYcT56ipJZhGlsjcbSJ1aWTWPYoQDYHa775m1oGlviw8Zem25b4Dkam20OttaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086615; c=relaxed/simple;
	bh=Ajif/9j7M/zsqMVNXdBm2tkQBVeG6jrR2PglV/6xi7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p5tjdhJBKCyHEG5wQgXep6hH7CnQUi4IcvdNjSwyvsY2ZC+ZtBIwUXQIqYFWoOt9YgObPcpHtQAm5uMj7L/ZJIkFBDcaPectGoLQbGrhJgIyTU0iW9Cfy/yGQiu2N3ON9x7bl/kFUwEgBa6l/RHH2ytgqZDhnkXsdzsbB1OXw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Kfj3SS09; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc5e664d52so71644339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712086612; x=1712691412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffbeIo6yT2gnuWj86yFH3HoV79Ov5Gn0g1nar2qmPdk=;
        b=Kfj3SS09wl8NNNp8wBeLKn4Fb9EJokqF1eQIr2FgIdxJWqnmxY89FAX4eZ62j5bPGa
         15w4Smq2Ob/iPLhZZDIet7pzOTuBpKtuUw58970nbPF5P3uY+pWoF6M4x8CnGweE0RWm
         M9njRWMllpJEmGLSPCpHvzD8tZvW7HHZJ7as0kgZakFSFB+bcg7hf2WmkhWKjWc2dCkZ
         aYTk0Qd4KZZVGDxHIKIwFqk9T5wB/CmS3NHkL+xftfctSW9efQjkjkWZc+YL6GDNxuxH
         KKDZfIrK7iSnbEklqaY/V0EmuDHlAgvNtQiCG/LgCotVYHdvJFCFR1KD8Tzr6RbWHNs7
         BeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086612; x=1712691412;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffbeIo6yT2gnuWj86yFH3HoV79Ov5Gn0g1nar2qmPdk=;
        b=T3wBFLvwq4W3Ma2IehqziA+QFHLp/OcxmsoNmgyaOay1hqVMG2CjpAaqGRkjZGxLam
         19Utoe2TLqtc+0CuHR/HmXwigfHI6Is0bVbTTHTwkO7s8d74VCDrZ/q1oDHszalCDJ3m
         Fx1bDVQtwMXaF5godugX1SN3CwKRltXXEzte+dlrFGHrtXMJTQ63VI/2Q8RmkL03MPft
         +0NFl8Ye54y8CRv/sxV/YlV+s6oGEyK6LKci7NWzTsyOv5PfPXT5RYbk/0YznNsd9CND
         wYcIfI2VZZtg547Q6xIMGp8LbWYI8M476bOmnUaAVDmXV6lSqBfsBuIjL/FHBuh8zK5N
         xckQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxJhK/FQgWsMjE1gIN3UoXK4XtG6G8ub3qFRhS+8pCSzXNSfBur9DnQWaJwF53NC0cL7/JkfZYwX+sLGk1Q85cCSThn1VOr6pWP3y0
X-Gm-Message-State: AOJu0YyKem7RY9o8LahUlTP9CkNWCfPX3mBr1CpSgK4i905fhjti+uaQ
	lqJR+DsP72KZmDwi+UoOWaBd7m+27yGZeCkoW9578pwNt9U2XCMDSiVw5p85/qQ=
X-Google-Smtp-Source: AGHT+IGkboOTfjsINZ2pc3fhknP/0plt8MY2ueAtvzQtuiRK3voiGIWqMn9regtabe/Az8LfA2D3MQ==
X-Received: by 2002:a05:6e02:350c:b0:365:224b:e5f7 with SMTP id bu12-20020a056e02350c00b00365224be5f7mr14486036ilb.1.1712086611839;
        Tue, 02 Apr 2024 12:36:51 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d8c5000000b003688003d036sm291713ilo.61.2024.04.02.12.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:36:51 -0700 (PDT)
Message-ID: <7bfa6e57-11e2-4a48-a024-e92a379b45cc@kernel.dk>
Date: Tue, 2 Apr 2024 13:36:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] kernel BUG in put_page
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>,
 syzbot <syzbot+324f30025b9b5d66fab9@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000002464bf06151928ef@google.com>
 <a801e5e8-178b-41c5-bf76-352eabcabf45@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a801e5e8-178b-41c5-bf76-352eabcabf45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.dk/linux.git for-6.10/io_uring

-- 
Jens Axboe


