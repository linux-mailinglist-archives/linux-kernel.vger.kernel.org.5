Return-Path: <linux-kernel+bounces-43531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8A841532
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49151C22D54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467CE1586DC;
	Mon, 29 Jan 2024 21:40:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796961586CE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564406; cv=none; b=LleCV/QZkeOGYfy1bNIDxQFAfMLwExmjxUFy/g2yZTmPzWq8fZQlXigruMQpT+LkfiiHy1lT9zX2Hx3VRE0xrwNptwJAOsmMDfjYAT8P0I0FGI0jeuyDPGlLYCARJqSzkKVnmJypNuPMIxLvfijRcc1t1pLooHUstbRjHwK5Pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564406; c=relaxed/simple;
	bh=euiU8terl0EWpgqFQ5bL3X18nbX+ON45QTpVACbbAjE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VVmon5fs3dGPofw5PeiCJHxI+gpQAudHPv0azepaaEGlAlFYM8frfJd5s1rnHXBkuuX5SCI2oVBwZzLi8l/vwxhdzMcLKkkz6O9WQRZbcxD44PDDVnEmIuL0rd5o0aHT1nmq0rboiPkiPVsAu5EIKfSbhhyoqWW4Ihha5y3BLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bfed339137so70183939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706564404; x=1707169204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LaawQ/30rYEp7t57BKkjQDVYrmgcFT0eTG0oi7N4Mk=;
        b=SRQcsMgB2LfnVd8P5ldO49RdoLKUObuT8EO5Vzl5luewdAqnPRfKxnykejfEvMLGkf
         uqFZligSTXMuQppq5g7hGDzojLmgdp6wltxR3MTarrpL+7GWnz1y3IU4OB7JxqVvy1Ni
         9uKuMNMe0fBN9hT4seD7GKtJrjvTceXAdkBy1CpvuYiPXHVpEtyqw/3TQaWaIv/Fx7F1
         ZHyOIFrRrhYg6aacAtPk1dmXIg0QvQJxKmuQsrsdYUwqFcKYsNtNSSaMYNB1Lnw5nW3r
         yE/yRpPhtJjDi9TGDgFiOphBTRbKPT8WyuEVJhCjx1bC5JvSdE+x2o/7WVVuQ5JajjSv
         l+mg==
X-Gm-Message-State: AOJu0Yx3ObjMuOfrNsSL6x3iGUMjm/ldj90OlOVSqxYxzyIZngf4ko8t
	uKvlZ2uz+EfsrdEv44oyIEvUIkn6OnKoHMnYA9Q05Q3vpjTD+Wa0uDZM5S1DLMg+gRCiUtfK5qY
	Bl7UsAB9b9KBLhDiO02Rq4TJGHuSGMH1Q4bsCs5xJOUX5pH+C+NSzNzlWuQ==
X-Google-Smtp-Source: AGHT+IH/rAoBll2QX2Bw5FJi7vglItWJkRQZ2a7TLRDAlq5HczdzTf45HoAPOHJVsP052cmunJcm8mUFa68jJ/0JGfCJ/DjLKFqq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:9412:0:b0:7bf:f336:802f with SMTP id
 q18-20020a5e9412000000b007bff336802fmr55292ioj.1.1706564404691; Mon, 29 Jan
 2024 13:40:04 -0800 (PST)
Date: Mon, 29 Jan 2024 13:40:04 -0800
In-Reply-To: <a24c6301-3408-4bf6-9c56-99685e1c8e47@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020cb8106101c7d6e@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
From: syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sinquersw@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git@github.com:ThinkerYzu/linux.git/fix-gc-uaf: failed to run ["git" "fetch" "--force" "7f85d17015ba166311ead463ef566bfcdfcee3b7" "fix-gc-uaf"]: exit status 128
Host key verification failed.
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



Tested on:

commit:         [unknown 
git tree:       git@github.com:ThinkerYzu/linux.git fix-gc-uaf
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       

Note: no patches were applied.

