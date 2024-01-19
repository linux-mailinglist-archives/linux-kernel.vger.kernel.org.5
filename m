Return-Path: <linux-kernel+bounces-31201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54591832A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEC21F22A58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC953E20;
	Fri, 19 Jan 2024 13:27:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809B53E18
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670825; cv=none; b=TV1qpytQnM3MLlpP68uJPMHcDWUiPXi4SKbrjss4SY5pJKcohTtXIb4CzZWnJ+Amsh5pE9XvsmkTyb2cMlEC5jfcbtio9s7LDYEYlFG+JFp/8BiDox2ueHMsMTuIEuQw5Dk89XVVMHVFyZfUcGzB1KgWoaXvvBSIMiLI8jTmqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670825; c=relaxed/simple;
	bh=rgtudZZcADzLkHbzNldBWBixKJSfqWKiGj2a7fsnTUY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QATsdiqCsDiGtQmuiZkOFwmsKm26oL0bkR9QpYnznSKArF5YR70/aIx6Fxlr/56+GPy6FGnnP0SSeVdRgDweCV0U8wVYSspUH6V2lQheWqHnsM5KwL/GQ9VzO4hiueljEyCrEjF3yDjm9FHP/v3sq/cEaAL7AxKjO3KThKmZPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bf44da02c3so57076139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670823; x=1706275623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgtudZZcADzLkHbzNldBWBixKJSfqWKiGj2a7fsnTUY=;
        b=kNffdQDf8lMrmviMQWyQKpGsXDhs40tX1/RaVx5pkTZ2gGSuVi99O9ks0Nu13UB0vj
         +1JqkUDoLnBUoDFhM+6kIrHbJqruwlIYoPHi6CVFtO/tcyfagJtgwMWEDIOoTAVtqEGU
         R4v7nyQyHaKizxjVwBDxPv2KPG8iv5400R4CJqO9LPeY5V1evUZ2xDuzfEmxUSEiykzP
         aSBfJCFcNiPniipjofjEcJj6h6fdADn4HnHHKmsbZEeqvpf8FCYWn/BaDAbBA1WDRIac
         slcyAsfGJ7jc5TeI7xLb0IGNLv40PhE+6sajygOTeefkGlNwn4hgRWVSnz6WB87cQw4a
         oSjA==
X-Gm-Message-State: AOJu0YzTpBmbQ44iI9WCVIvg68KL0+cfKsuT/wmpRj0Wj/qFvdU92XlJ
	Vdb1C/ojmiau2NtwMTI1vORAEBeYFs3YLxXuFOrW2JbH5N+GOi5AnVG9lLlPZuZf2lIfFUStrX5
	ORZt3Tbf9O24ZYgigTqZif/htfVFdGANlBEjUQBTjzMSO2m5L6dxpePGtTQ==
X-Google-Smtp-Source: AGHT+IHErbubnXpCTDSsLjo5CDmb739Avmz/DA2UxK2vswc2ene9Kl7MvOIpm5mmTw9oVZAN1MMpprCFM1/JfyNBwGQ3tcXVkmTs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b0c:b0:7b7:d7af:97cf with SMTP id
 p12-20020a0566022b0c00b007b7d7af97cfmr123823iov.1.1705670822995; Fri, 19 Jan
 2024 05:27:02 -0800 (PST)
Date: Fri, 19 Jan 2024 05:27:02 -0800
In-Reply-To: <00000000000060446d060af10f08@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000823321060f4c6fa7@google.com>
Subject: Re: [syzbot] [syzbot] [can?] memory leak in j1939_netdev_start
From: syzbot <syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [can?] memory leak in j1939_netdev_start
Author: n.zhandarovich@fintech.ru

Test to make sure the issue is still standing.

#syz test

