Return-Path: <linux-kernel+bounces-31385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 004D5832D91
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8577AB245BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450C255789;
	Fri, 19 Jan 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AB1ClfGu"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DC41C98
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705683360; cv=none; b=hDUmM+RH8sO4+wlfmsqS8mwV4jGZ/UdtGibpZgFaJ4uIKYUaQRiC35n/WCO2KhVXNHqLQj62WHObWSaYH1gBE0+eMbLV5YAjDh/am7ViKSDG3RtRUFKXnBIZE1ULbETgNIPMQHG8NHtyBNGL5eJlR5ukSIVLhsztIeUvnIY3/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705683360; c=relaxed/simple;
	bh=OadCu/m5vzfYd0qEMpWx2E4WJ5vsZOOq3PXuAaZQW4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhe/P4KUtlbIqzMWF4nj3B9ng/GKtNqJAQenBwWQ8EM2YNTMQV9SJKwBX6H4pyopwZCgyDhpWCNGV9vAxCR2hPijvyorYsXo8YigYrdZP/GIkf3WG8w5xIDhWm+37Lkdq4+hz/OAp5dz7wI6mPxTtU09LG4NPxnmbFrkmGgzqTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AB1ClfGu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d47fae33e0so190975ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 08:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705683358; x=1706288158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HArH+f49lUIhW8lGbcTKSsHFS75tTmPsJ3Gy+DBQWIc=;
        b=AB1ClfGux1P791HFjcnUTC39Bj8vFFPXv9kaYBNdp0GGVI++8FEXTTk3td0P/vjtWO
         ofW8CktvvI6FBsV7tGDkLZGgDno/fT77vwI7ISmv003w8ISIwTK4fk5fHfGnFoJuPthQ
         tBkijxsnzJ9sGSCUR+9m8O91o/iznDuXaQ/eRFyxdZHVMbzv2CZoqJ7BBdqZN3dPSSYf
         LuEZ7g8x3Lf+4Fhq1Acu1hBOzVhZFCz0pX11UEVKcmISM1psB1mbF+xyxdLLpUEPMIyp
         dNcnYfXB7OFeSVivPGEabQrMTIB+CrgTgdhyQm7jdl8q03YS970MrKEPSqrBFh0tKKvm
         I2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705683358; x=1706288158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HArH+f49lUIhW8lGbcTKSsHFS75tTmPsJ3Gy+DBQWIc=;
        b=hnDLfL9FeFs7qmQRAMknzLhrxRQKNedspThDNUKkQwT7q/QsZKNEntB34gxToow+go
         dzOepoXrrse0moDu7Feh+okFqtQ8f+AN3gZMwGdPYXwyhz52ryEurZZIFIjGfsmramgF
         6Tmv3DKoP1y+Y2YQghs0NeF1/fbrku8BglbvPl+dYHTIYu4Xm8cNMDAC18UkceJwnAKp
         AfHHxGbEN8RiPZ50WCzYsBABNGLkH2vXLmC38j6rjUaKW+SmVDDDEkz0Bh3zNtczIkw/
         JrdHW4Mh55aog7afeMeUOlKov5ZeZ4f0au2XHO8YvE/Pj8ll6DwOxFJpoBM+GVNKYZdo
         jd6A==
X-Gm-Message-State: AOJu0YyPLQi9YdrgqsWlPflRJM9xw7G7HLTiu/cWVWwpbTSaqTN3wC3K
	9dbyzrEL2N9oeqlOsaVzE++jHwQQw0sWL+Bw5kKxU2p9YbCOFxRmfteey/e7XjNMhOCo8BTSGJw
	scQnD9qThwfIKkPQR+WACjWrwx+rYgczrgodI
X-Google-Smtp-Source: AGHT+IEfQz88XP/75ySHFEIz3CgN+wCm/H16+6XqrsUJI2JsHKKpFviJRCbcGMBy/03nBkr0KqUEW0BmjzKTksLK400=
X-Received: by 2002:a17:903:1104:b0:1d5:a2c9:6e7b with SMTP id
 n4-20020a170903110400b001d5a2c96e7bmr243041plh.14.1705683358337; Fri, 19 Jan
 2024 08:55:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119155614.4501-1-n.zhandarovich@fintech.ru> <000000000000fe4ef1060f4f287f@google.com>
In-Reply-To: <000000000000fe4ef1060f4f287f@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 19 Jan 2024 17:55:46 +0100
Message-ID: <CANp29Y5w86RrZPNdH0UqNi9m4po1swUH75153FEtkw0BduE9xw@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] KMSAN: uninit-value in em_ret_far
To: syzbot <syzbot+579eb95e588b48b4499c@syzkaller.appspotmail.com>
Cc: glider@google.com, linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think it's not entirely correct to test it on the kmsan tree as the
kmsan tree is actually quite old (the last commit was 6 months ago),
which is way earlier than the point of time when the bug was detected
(syzbot found it only in Nov 2023 -- 2 months ago).

https://syzkaller.appspot.com/bug?extid=3D579eb95e588b48b4499c

The bug was last hit today on the head of the torvalds tree:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=
=3D9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e

On Fri, Jan 19, 2024 at 5:42=E2=80=AFPM syzbot
<syzbot+579eb95e588b48b4499c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
>
> Reported-and-tested-by: syzbot+579eb95e588b48b4499c@syzkaller.appspotmail=
com
>
> Tested on:
>
> commit:         d1d7f15c DO-NOT-SUBMIT: kmsan: add the kmsan_exceed_ma..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1726e677e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6b301bd980290=
807
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D579eb95e588b48b=
4499c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
>
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000fe4ef1060f4f287f%40google.com.

