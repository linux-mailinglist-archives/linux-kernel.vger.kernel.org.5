Return-Path: <linux-kernel+bounces-105203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4887DA7C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B966A281F68
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262E1B815;
	Sat, 16 Mar 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U2/08xqq"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6818045
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710600141; cv=none; b=Vjj1Wriv6EF+S9Sgt3boCdXBYjJKB8Z3h2ii+NDrEfiOPTaNtu0Prsd6fMrbjrtCiN9CxJBY4sO+LgJdGLyrZMNTv/z6zEvwaCTFyln4ZtVf+ly4rb0HSWG9FKWeAXxnZksBOH/mpECIg8adhOYOTmttuWzXhVecGf5hrfdhmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710600141; c=relaxed/simple;
	bh=9IKAL9O5Kzhj2bWwcxxcLVVHc+FpAsBJbr8QW4g4aUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OC/dfjqJ+zU3ymhZqNRt3hoJPgm5ojf5+u0WD07i8YnyOdBRE+JJZHTW1dxJy4iHvZFay2WuSaxUPSENNOvq6vJnTX3XK4Bv1PpZzB2p2eznVRItIvSB4/xvB5wQb5LiAeC4K1/0xuodfh9DdebhNzZAAnglykZ2XFt2gIblPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U2/08xqq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1def81ee762so2660375ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710600138; x=1711204938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=021yMPdarsacqdEo/8CW8u8ZNpKM/XY65JYdTMbED3E=;
        b=U2/08xqqzuf9n3embOU+7m6bSUmbdxQ6qEvOqfZMMhdeTxjDeVl6Szjzojequ+cO9x
         9wigpcN20Vi/tfnWesbfEZQJ3WywyyMOcYXwg/msPV2rJffuGDkitH8UL0ciad8WsRW0
         6pdBCi0DwQLK1lcxqu4/f8qIawR+gDKPILpkOM6m6w42Y0MdU1hWaSBxw1DcA5JHa39x
         mMO+2favcCGFFP250oHUUcrITvGR50sjI82kIfSk24wzkOLWABoyG7BiQFsV9jEi/pui
         A4r+KwZQTMUC77hIQexLVFIC2q+v3MyFFWJ5pvtVdbSdQWG3JXk6JTRTNvc2iuFNlNa/
         qlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710600138; x=1711204938;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=021yMPdarsacqdEo/8CW8u8ZNpKM/XY65JYdTMbED3E=;
        b=WuSs9iboOfDIMD2bEbvI+5PycvpgCAjma5bLBnr5jU5ADl7JEbxrsauiIwGqF174nW
         wZ7TK7OBub3R5HE9aE5pGGmWptQ1tKqD6eeGUKCncKFsRN7vpL6fHB8tsD5eA+2mTGhP
         tvnNok6UxBNclhrHWUowvQp/sr+1bYq3HWCPndW2LuTJ68hLrkceyYb7bGoSlEg0aHvx
         aejk70N/iCdOH3CxpjGnq+fCWrPqYgRdf9wM9bYh7cjIsr+DgccR0NS2Tiip9YDnluCj
         0e7Tn/tcO1u0j9ODROO8VAHmJhelhBA8xecBEILnjdHa0rb5LRrbrGJB9SBh9aY+rgLY
         vn/g==
X-Forwarded-Encrypted: i=1; AJvYcCUrFRKVaobLjzq8xFMi5JNtKLtk/mgduGDEr7h6fE2S5QLirfqW7XKBYAsUoD+38dDLRXsG0ZPYzgd5tfmjrBw3pBxEiYOmKe7a/op9
X-Gm-Message-State: AOJu0YwiQCrfOFSSCfShSAhpHMxxoPrg/dQzqIbcqe2SH6DNzdeqq9fe
	6DjK4F4MN4lKF+DSwydqDHORe0L1y0VNhCzTSgpT2Ik4a1tMezrkEhXS64iXgcw=
X-Google-Smtp-Source: AGHT+IGRV2wpfsgw0/oWiKlOA5lxTdHAopriGaXb8z161t0SWeWao275fL5/kxza9A9ZbURzltxiGQ==
X-Received: by 2002:a17:903:186:b0:1dd:6f1a:2106 with SMTP id z6-20020a170903018600b001dd6f1a2106mr9296394plg.0.1710600138520;
        Sat, 16 Mar 2024 07:42:18 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902e74300b001dcc158df20sm1453789plf.97.2024.03.16.07.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 07:42:17 -0700 (PDT)
Message-ID: <8e639192-cb6b-40c3-9892-db0ac0cbae52@kernel.dk>
Date: Sat, 16 Mar 2024 08:42:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
Content-Language: en-US
To: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000003e6b710613c738d4@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000003e6b710613c738d4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.dk/linux.git io_uring-6.9

-- 
Jens Axboe


