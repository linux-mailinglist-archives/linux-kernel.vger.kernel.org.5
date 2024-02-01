Return-Path: <linux-kernel+bounces-48330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9A845A75
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E981C26ACB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A30E5F484;
	Thu,  1 Feb 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DhQIcBl0"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E85F46A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798617; cv=none; b=igzXsQbnrWIAbePitvWACakati0KpXRm80toLT8JNxsuOhChaV/JMnb73aE8IKURT5LywWYJEvuNJtlnSuZ9Oxso2Pj1269EVWHRGJAQH+2+j6BJIKhTHUVyXmkxIttlfMeLcJ8ueRK1mprJc7txaeurqjJpcy0qVYvWQja9Ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798617; c=relaxed/simple;
	bh=LMmXEXjre2/iGvw1iKk547lgHHliHlwLOLSwpsYtPLg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=GV/JWRbfpwFRkPd/aGcyd1/hyoWy2VPBDrQwjqdeBze7T8BgfVS2v64NQJalTVKlevTQ/jCLsvTEF7d+C5sKnzmx922ajV2P3YZ5g5i87yhNTbK7httDBg2cqbijS1TRYZQbttvOvKnhcS66YRwtiEtEq/ylQOQHPUsKdzmleiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DhQIcBl0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C21F40F6D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706798608;
	bh=1OypoDLTCeqhHTjTBtuB8gkBgBKZCfgLJtgtDYgi63s=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=DhQIcBl0C6I9/Kgisoegrcciauv5cEiDkxk6Rpxsf11p1iRchA5yqlnHQ81fMM1ko
	 /+NBbyDsElL+GQT4+C/miItSc37ZK1v5t8pqK0hwddByAItmj6KT3eyyw61JgN7Dc9
	 Yf1/G31KieEFHQfu0v8Y9xz7TZe92WLZRCRIZ7AcXwUGHBQe4rEX3zW5QAdSolD5jj
	 gvQ62GSltK8OIoolxSmH7wr1N03xtfQWKMI9Dq3aqzkdDl2LXuP+We+W0C11M9v3kG
	 rXR3SZRDGXNgdFlRIG+CJNfpbYuVjPuuKT1ghyhckXgjsauoTsGnX4NsbFuJlZ4TCf
	 GbhFCoDAUWP6g==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cf35636346so1023915a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798606; x=1707403406;
        h=message-id:date:content-id:mime-version:comments:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OypoDLTCeqhHTjTBtuB8gkBgBKZCfgLJtgtDYgi63s=;
        b=PnEGYP3Vy3oQBolwOMe8Uv/wwysKPF6OseNSySXaCmY8qEtaBjIhvfip92QwCPmlgc
         at5vvk7OJrjzXuA6vqetgrWHewHFhT/KxUIfkeAbcDWvr23KwFsTbVM5/9wStS4Kn8JJ
         aEwZrqxorSeCRVPJDn3FwzFzHoj4KnTtUkIa5wSWrwRsz1qRGi2gCbRCcOuuTJC/GRY6
         epBd40xMkv7hqQjHIwN73HEQz0C6eVtT5N6cldVj4CEIGVFs1MlR/j00UXN2KK0I+Nvk
         icKkx4Iksgk2x61mMGPDQxokH3QdbVwtLb5SpX8TpZknJUwiF6A3puclQJVXRhanVvY/
         gQJw==
X-Gm-Message-State: AOJu0YzQGOHWuIe8eLBp19sSCUgnv6rIKJvkLvxTH0252gki/swAjhaM
	Yfk6W78F/5kO1YGb6VKAznYTdZUJRE6blMbfwS35+B+ce/FdmQxTv0WUbHgaSnTWA9SsKG7x8w5
	vDCewyvg8wHWqdg5/WQfvTbtOLPz/qqjrDxGc8aZ8izLt1NLq45UyM2oZRYcCKZ9PS2J9CGEQmt
	Ymog==
X-Received: by 2002:a17:902:ce92:b0:1d9:4544:ed37 with SMTP id f18-20020a170902ce9200b001d94544ed37mr4105695plg.17.1706798606632;
        Thu, 01 Feb 2024 06:43:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpy4TEPVPmqROCvKm63XB0+LwNUI/U6Orro7bqbYxr13caUcPj1evnQ0OegqRfN3azkrleaA==
X-Received: by 2002:a17:902:ce92:b0:1d9:4544:ed37 with SMTP id f18-20020a170902ce9200b001d94544ed37mr4105672plg.17.1706798606343;
        Thu, 01 Feb 2024 06:43:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVw+pYoH0wmJ8MC4sML/8pFkGHrVLIq3wgZbBaZsrMU7XGYQQ17YCtLEMUROO+qBdcVRE0QKYvzpw3D0cCSwxTkPwprC74nCCtOU1RKNHhNFNMQTQMwIA/BdUpiH3o6y9KA+Mbkv7PROxVGpPDOwAPTw+BEgURhkBBmlawNkb3wBj4h87puae5tU8jEaXnN9actXFBTA8F5Fm3aHcR5kFeUXJw1gm2GPvAj0zgzqHMzQ7rJMncC6r8TjoRvEEnJaneY9A4GscsCxCcOk3JPjLMDOMAw3QEgGJHPd8WM6WvMlWfJpW9EVcZJpe/etms2BL3EJKrIY1fT8RzfeoEEx8uijr2hqtvfr4xlvDXaepXY9dXvYFH8qflpcgTCXVZ8s5hxQdktOICy61rqQb1Te/E02uUpVkK2dgv1htvp
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id mm12-20020a1709030a0c00b001d948adc19fsm1579796plb.46.2024.02.01.06.43.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:43:26 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 885825FF14; Thu,  1 Feb 2024 06:43:25 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 822509FB50;
	Thu,  1 Feb 2024 06:43:25 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Aahil Awatramani <aahila@google.com>,
    David Dillow <dave@thedillows.org>,
    Mahesh Bandewar <maheshb@google.com>,
    Hangbin Liu <liuhangbin@gmail.com>,
    Andy Gospodarek <andy@greyhouse.net>,
    "David S . Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Martin KaFai Lau <martin.lau@kernel.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] bonding: Add independent control state machine
In-reply-to: <15d7f2941394e04d45f98aa6d095b1e07262655c.camel@redhat.com>
References: <20240129202741.3424902-1-aahila@google.com> <15d7f2941394e04d45f98aa6d095b1e07262655c.camel@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Thu, 01 Feb 2024 11:15:40 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32423.1706798605.1@famine>
Date: Thu, 01 Feb 2024 06:43:25 -0800
Message-ID: <32424.1706798605@famine>

Paolo Abeni <pabeni@redhat.com> wrote:

>On Mon, 2024-01-29 at 20:27 +0000, Aahil Awatramani wrote:
>> Add support for the independent control state machine per IEEE
>> 802.1AX-2008 5.4.15 in addition to the existing implementation of the
>> coupled control state machine.
>> 
>> Introduces two new states, AD_MUX_COLLECTING and AD_MUX_DISTRIBUTING in
>> the LACP MUX state machine for separated handling of an initial
>> Collecting state before the Collecting and Distributing state. This
>> enables a port to be in a state where it can receive incoming packets
>> while not still distributing. This is useful for reducing packet loss when
>> a port begins distributing before its partner is able to collect.
>
>If I read the code correctly, the transition
>AD_MUX_COLLECTING_DISTRIBUTING -> AD_MUX_DISTRIBUTING is not possible,
>am I correct?

	That's correct.  There are two completely separate state
machines in the 2008 standard, one for coupled control and one for
independent control.  The state machines utilize the same states other
than COLLECTING_DISTRIBUTING in the coupled control mode, and COLLECTING
and DISTRIBUTING in the independent control mode.

	Essentially, the two machines differ in the transition out from
ATTACHED state; coupled control moves to COLLECTING_DISTRIBUTING,
whereas independent control moves to COLLECTING then DISTRIBUTING.  

	The 2020 edition of the standard combines the two state machines
into one, and changes the set of states.  Bonding does not implement
this version of the standard.

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

