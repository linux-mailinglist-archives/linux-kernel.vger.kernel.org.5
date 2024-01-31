Return-Path: <linux-kernel+bounces-45732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FDC8434BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F01B2183B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EDE168A3;
	Wed, 31 Jan 2024 04:11:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF4812E52
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674265; cv=none; b=HPDS4qXNLORzbJ/tx58oqiOa3DcrwPIkGAFLBF0c5SJ3zmQrrCBZWytYSVUu15NhD2NSHq6DcsLLMIrpHJEkowBshuxq6TY1eyBPEQyduQp39r4emtsyn2Ur2eYpHF5MadbbYnNuJ6CAV267hQ8lxIzZeRFxdtYINigp481iXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674265; c=relaxed/simple;
	bh=r0nHrEY6XqozmITj4st0S/Lf9rZUC2BsabsbUeeklQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f9cfdeJD270+wn4FUwpZ5hgIIvZvhFI1Qf0jsZpxk1A+yN+thMujnc0YkszOrdqTC4QsJMU4LrwpHWjFFtFyQnpx9nn5Cw+6BZ2qjsFXcuvNRRhxJbWvisx79duv2Ktn+k/veI/2JSO52x7vCh51qOUO+h2ixMSbGhCh38PMqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso525240039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706674263; x=1707279063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0nHrEY6XqozmITj4st0S/Lf9rZUC2BsabsbUeeklQ8=;
        b=a7pwTegpJkrRZ+AIECBj/YUOyCFAKMpNLj6TwvyTKpYzrLVqgF5cFPVExV/fYMHkjF
         m/gzQM7Vw+7XEeKm5/oDn6P5+gRoVTN+qpE0HBIA56aXAQG5X57jwSi5LrH+7/E/nYYe
         cs37qQM4NL0MIZEHgOUHWA7/B3gT9z41UESmgo6vll+O7TuvKo6/F01JZs8Jkm2zdxts
         1RlOvLv51z/+KzuBxYOR0q/JrhxQ9Nle865xqyFJwNRa56SaEcaCKtUiZmzayotxSRcX
         nbgJxCs6DZ7m0QtETjaH9Od+09vTouarEwOMOkMGUt9b6Bxzu0P/RKEv4e+28YxlOiL1
         F5Xw==
X-Gm-Message-State: AOJu0Yzoo/GtZSWnwzem/bxP1xjwNRgJp4wtm4lgAIk5/BPTGNVwHi3G
	I7K3v+edBO1NJBDaeu5OTNxTuUa4/4LavVPFoBRaREAKf5HPHt7UAdbkp008GOFXWp3dT/qrukh
	w1/d9wmlPznpueWebjk86gTWgdpw95oE0nYNANds8WrdPpi4zdGJUjMpVGA==
X-Google-Smtp-Source: AGHT+IGCf98HEJMCzJNmcCzCwrBeDA2QqCYe4645LOoDG196phDDVoF3wQOzI+JcJS0Cgl1LKAn6S5eM7QWavtkLousKOdESka/7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:361:a33f:36a4 with SMTP id
 k5-20020a92c245000000b00361a33f36a4mr50454ilo.2.1706674263260; Tue, 30 Jan
 2024 20:11:03 -0800 (PST)
Date: Tue, 30 Jan 2024 20:11:03 -0800
In-Reply-To: <0000000000005315c105f1652480@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035876106103611b8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [rds?] possible deadlock in rds_message_put
From: syzbot <syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [rds?] possible deadlock in rds_message_put
Author: allison.henderson@oracle.com

#syz test: https://github.com/allisonhenderson/rds_work syzbug_f9db6ff27b9bfdcfeca

