Return-Path: <linux-kernel+bounces-160132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95B8B3990
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCED51C23AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA661487F5;
	Fri, 26 Apr 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WUMD0kVa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE41487D9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140821; cv=none; b=L/7N8PHdyPilQ//5st4q1oWz7s3jMLJ4XG+flMW3NZETOXgRBvmAVsM6fPFChvbUZdFW3UDxFCPUK2CUFe1XaKWe/dKcjn139h8xoNPdMIgGIQyvFW5mAKjx3unR84LmsBSrsqFRkhGYlbcw8B9bhfceUFpS5aZLPOQmaa2yeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140821; c=relaxed/simple;
	bh=ocB2/yBahioCI7/5O6Om9U6ZLQrJJRWugwT6+xyfoyM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QAM7L4FDY/F7qOz1xDd+nvi3R+v/i7kXOGhJP8kFL5jZVQ+muDk2/J1WX/bDEw7yj8Ez4cviOD48w+IX04j7YjWxI59J90lrKrbX9Txw/QQ0bY6B5akAls8mx6HMLhNMRqeMPJ/bDKjD5xDxobDcOpT1ELccsIbaOzgZH/6f2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WUMD0kVa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e974905beeso173375ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714140819; x=1714745619; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyxkCSdZRCibYcIkiKjnDBzaWt3TngY9NZr7QZ093Kk=;
        b=WUMD0kVamiEXWqf2oXPp2eV9MShY7NpMJsIGFs/IJQeL8FAI+E8gIE7rj61HkXjc0y
         O851VAMPTasRSfX6HIHcDqfv1SlGzIz5cxlO+p0aKgR7oM8LArUd/6emTY2N4GlCUayF
         5LXPaMlNTXUwcMr2VU2XQsbhDt2QYIrBA1hvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714140819; x=1714745619;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UyxkCSdZRCibYcIkiKjnDBzaWt3TngY9NZr7QZ093Kk=;
        b=O3oFkcL8r25CRpLquzGHzMtQzvJTs6rcMTgbrv2mrC8HcUG/V37HTa8wREtU7wndVh
         NWGuk+UcHtwg4ZEtNGy2IO4oNBU3od1k4JGyUC24B4dYr4dSrZwd6tBacOSID5xX5gje
         EWWeN+byi11OjDSZLPAhEHfekbFZYzH7C1Jkw+RGpfGPBDxd99B8+6qL2VSbfnE2RjNK
         Yy26F2hdDSzZOt3A+CGKaVgFcN2CqPc8kuOKZiPmV7zK+Ib6P67piEWvvZKVZWeF5vto
         zukJjzHLaoSvubIpkpD5vCShFlPCn1v9wCA9CokkCCU4JXus9LUXqN15308VWVkGGvro
         Z8qQ==
X-Gm-Message-State: AOJu0YzcYUWFgoVpchr5mK40+V0MYIWVpZO6ld0kzB3NXkstJWQ9k9wA
	WNe6y3h4+AEM9Bk70sKSPs5/6G4mqdR8olK2Jt2y1fiIvxAY3he9FdaVvWXg6idxCx6F3uB2rTM
	j1c/H0Q==
X-Google-Smtp-Source: AGHT+IFhtGoaWWpEjq0uxvoSo5xR2MxQd0Y1AdzKFuTO4Ov8w92kkN0+Hw7QM40sQG+12d/x5fitEA==
X-Received: by 2002:a17:902:e88a:b0:1e5:1138:e299 with SMTP id w10-20020a170902e88a00b001e51138e299mr2989945plg.1.1714140819023;
        Fri, 26 Apr 2024 07:13:39 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001e2ba8605dfsm15756776plb.150.2024.04.26.07.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:13:38 -0700 (PDT)
Message-ID: <355aee5f-13ce-4e20-9ce8-e5bcddd14bc2@linuxfoundation.org>
Date: Fri, 26 Apr 2024 08:13:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "conduct@kernel.org" <conduct@kernel.org>,
 tech-board <tech-board@lists.linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux Kernel Code of Conduct Committee: March 31, 2024
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Linux Kernel Code of Conduct Committee: March 31, 2024

In the period of October 1, 2023 through March 31, 2024, the Code of
Conduct Committee received the following reports:

Unprofessional behavior or comments in email: 2

The result of the investigation:
  - Education and coaching clarifying the role of Code of Conduct
    conduct on conversations that don't go against the CoC.
  - Education and coaching the individuals on the impact of making
    unprofessional comments which could be misunderstood leading
    to negative impressions about the community.

    The reports were about the offhand comments made while rejecting
    the code which are not violations of the Code of Conduct.

Unacceptable behavior or comments on a private invitee only chat
channel: 1
  - Education and coaching clarifying the role of Code of Conduct
    conduct on conversations that occur on a private chat channel.

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to
uphold the professional standards of our community. If you have
questions about this report, please write to <conduct@kernel.org>.

Please visit the following Code of Conduct link below for information
about the Code of Conduct Committee and previous reports:

- https://www.kernel.org/code-of-conduct.html

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

