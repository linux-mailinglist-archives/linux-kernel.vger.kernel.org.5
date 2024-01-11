Return-Path: <linux-kernel+bounces-23595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00A82AEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607FB1F24C40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F815AE4;
	Thu, 11 Jan 2024 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="jtIpjzOb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B315AC4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so3866165e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1704976775; x=1705581575; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlQjkQjyk1xjO1+lltG+XbCMeMA9HOeZJZxNsuhuvrc=;
        b=jtIpjzObMk+dR0zseb9hik62Xcc5IJyKKp1bk0WBv/Vj4K5iJwX7U6Vq99JP2BH+ql
         +Cyo9qYIdlSDocobgVu36UNEzivO7ped6SSO5AS7fr4/7tvVlE54NfZ4jOApC6YgtqDO
         mnlkHYzfTFrVHd+SZIFzPSYsHyhnZMkEK0wXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976775; x=1705581575;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlQjkQjyk1xjO1+lltG+XbCMeMA9HOeZJZxNsuhuvrc=;
        b=wwlfGaIHJm5WZYE6/iMZ8GkKvcHig6VK34uoPj5BZ0tb4t7nlUEqx1nlwotSlt+vNp
         lypPBs3jCTrpGAYIXVEPcLBzLBSY/9+H04gTYv1LfUT+mF8NDcNZty8O1VBrawJpIO0d
         6Askl0GE+R4dIZHBb/6Nr+zZkJvQEmMMbl1RyIq8tcXroueA/3Qxk9CE/yjVQ9YLmKBd
         v7x60iDvU+i5GVX4rzIJreUTH+fvW4pH4D4RoWgFxiJDxU+kPhgtwaJLDgesVtvYMC2A
         K1l1e83YnWsvVskx/R6yEN8MTkPnysCj+wb2zpabWkvjBXGwdXM0cC6LN9Nf3QId9dUT
         y8FQ==
X-Gm-Message-State: AOJu0Yx/7IVLTBnMuey8kxDlYOPdQ3FrPSbomgYR0JEPe28zzK4seObz
	1NwgWmdysl84mlFr2KNLrNbJR/pu46L/o5zQRE3x13pvNMYq+g==
X-Google-Smtp-Source: AGHT+IHw8GKsdd6L695n3kGHJynyBvm0DfPtSELQDgh4bA7bwOZNqwKCJdM2aYcFzkeOYuw8d4Y8Eg==
X-Received: by 2002:a05:600c:538e:b0:40e:52e4:6938 with SMTP id hg14-20020a05600c538e00b0040e52e46938mr394197wmb.40.1704976775011;
        Thu, 11 Jan 2024 04:39:35 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8600:5ee4:2aff:fe50:f48d])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c499100b0040d6e07a147sm1698432wmp.23.2024.01.11.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 04:39:34 -0800 (PST)
Date: Thu, 11 Jan 2024 12:39:33 +0000
From: Chris Down <chris@chrisdown.name>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
	pinskia@gmail.com
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <ZZ_hhT6N9tqKuB2c@chrisdown.name>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

H. Peter Anvin writes:
>We already *do* use constructors and *especially* destructors for a 
>lot of objects, we just call them out.
>
>Note that modern C++ also has the ability to construct and destruct 
>objects in-place, so allocation and construction/destruction aren't 
>necessarily related.
>
>There is no reason you can't do static initialization where possible; 
>even constructors can be evaluated at compile time if they are 
>constexpr.

Side note for the constructor and destructor discussion: should we be more 
widely marketing the __cleanup() infrastructure that Peter added a year or so 
ago? It likely helps a lot with at least some of these cases. In systemd we use 
__attribute__((cleanup)) pretty widely and my experience is that it's made the 
code a lot easier to both create and consume.

