Return-Path: <linux-kernel+bounces-147798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333E28A79CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0A41F214A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDA41CAAC;
	Wed, 17 Apr 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AD88wLT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EF182AF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313240; cv=none; b=MJ2KEOCVzpVw9U942jDZ5xy7WXLnAUic0t0xNn7CN5VlxQ+gANuauhtgxtjWaMOaYmHBz1Fp5aQCCtdAHPDDFW+YdfLkfowkGjp+uBX2P5e/8LEoHfVRMr7hU8UXUG/h+kB2kCw+yCHLxI7MKA6RLMMTdHUEzBN59ArOBMTbjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313240; c=relaxed/simple;
	bh=rKgGssGfEOKGkIRQeFs1TjmUY4hFQHkBkKqadyYn3JI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L53IkMjZGDIEb+uDx0/8SBpOLmACQUJ62+258B99sHxognXlNzFNZ4QP4lwmo2r2XwXqkmh4kJLOKtR7VXFGNzqWzHDNKdwv7q16w1IXWnwn8mzbCNOk4utTQhM5b/g+WjINspIZvtst2l/7LOLzctgthHJy5gKiqK8ZhTvMx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AD88wLT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso7537296276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713313239; x=1713918039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV9cZbvYcI24uBtMaKJ3e1d30YVtPK9cBpVUuoW5n2M=;
        b=1AD88wLTE3Fk6vyFcG5QXCn4++c3CGx1d2Ejz3vDeWeuTOnLfdZsmoTA1z8zHPKYU2
         6KVIWrb3EULP8AZu++xE/H2xUuBjvhv3HBAjum1e3BPtdie8QMAff5Kk08df+qsu9mLN
         us66scXDyxpUgUV5NfUy3euJq/oFJkEQ+dBXw63HXS5N4yRaN0YUUT0QJu2dwC0Zu49A
         PWOQHMeZVehjDBHCyIJEHjvpbCNwtikH6bGFg+K+eKYceu4tevck1tcn60/0LWg6LFwl
         Um5UCw8YeGFZLXgOFxI7LlIM/BhyS3Zfauf//GrlrQyr7TiLg+dwsOPvhswb8NM1AGeN
         rULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313239; x=1713918039;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wV9cZbvYcI24uBtMaKJ3e1d30YVtPK9cBpVUuoW5n2M=;
        b=PA+362YiywXyjaJ6aPMJTMdMqd2S/LwzMbSTg1+ZwbagkE3BCeCOoJQx8+uxUrDGZ6
         JxIviBhWmMXYAi8IM+phhxvAehFiquJ1dEDHDnayYorPe3RN1dGgwFot2ACEBl5sPORf
         h91li1hdxp+mLAlBPfcDX2zyxqZjtlqTVzLerPx3AAGvMR3Q0qmi1K0bMvIuSNiXOv8O
         afpCzzPd36d6MRMHHDhjSJl+wddLPlg6MYJ55kU9UiWcTZ3g7/HhXaaIN/wreHSb1VuA
         N3oVe6V1Oxvy2l727HGLVUHzXmtYZGToDzm0bvp95zR0Cs4Yg5ZoNWFQqrGQbpSU4MQg
         9PSA==
X-Forwarded-Encrypted: i=1; AJvYcCVD5KCe71H/kamxcC/lmfI7Pz1PxnFMHPbKY7QgWMw33S/acuZgaR/Z5MvTPWhP1UUXX60AEQ5mDd2WZwEbSJpsN1ldpHIKNgAib158
X-Gm-Message-State: AOJu0YxfcZDFsRLUJNqYMFfUhJY0myXvWD/kgfMl3T72XBo6Gw4sXBuK
	f8R5cXBV/jhrfnY+5dWlll3BTfCYOYnVNJSXW6Mh/h9yaxh5UTDMGIkbXiikzpEek0hJAgG09NA
	/jA==
X-Google-Smtp-Source: AGHT+IHYlFNsKKDROMObXAOA1BBSO2rcgRvoAGMMfHfg5xaJK3sOqayveOZjqsfBZjGffVPoMJWsRcgQB18=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c2:b0:dbd:73bd:e55a with SMTP id
 w2-20020a05690210c200b00dbd73bde55amr1742377ybu.4.1713313238765; Tue, 16 Apr
 2024 17:20:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 16 Apr 2024 17:20:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417002034.2265113-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2024.04.17 - No topic
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No topic for PUCK tomorrow, but I'll be online.

A potential ad hoc topic if Paolo joins would be: are KVM stats ABI?

https://lore.kernel.org/all/CABgObfZ4kqaXLaOAOj4aGB5GAe9GxOmJmOP+7kdke6OqA35HzA@mail.gmail.com

Future Schedule:
April 24th - Available
May   1st  - Available
May   15th - Available

