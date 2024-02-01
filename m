Return-Path: <linux-kernel+bounces-48836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398E846234
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3E428B6D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F93BB4C;
	Thu,  1 Feb 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WXSzkJrL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F43CF40
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821042; cv=none; b=lIEx4PjcxM+swxtMVozP1Bkn3sFVCHXwxFe3OV+Nde2gqPOlfRDN7kLF/kNjZtlv9Y2IQr4yPCfOhyRdjOygWtf4eMeL/WtJYUyqqEWP9TShljyDg7Py8HxwCVPZt0TyNTZhNB8NnZ0HE/wpgrjxSAuhS+1YCINqy/h8b8SMQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821042; c=relaxed/simple;
	bh=urrJyHrBIsQS9KKLtMLnx2kfVk9RVyLYlhfhNo7Fw9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc+eFbStOVAaWaItbpcqkc1qOnFSl101yJIafUVy6hWsVivm32HiP9LTP7pL6qvQTx0HC0jo6N7rWkmGYSUHAuGMPBhJgZLCDeIolduqbE6+u9kgxYF0diM/DrLv9w66kmUf6aUSz/Q/XMg46ia8SbKACH6sP95sYq6AhvTIA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WXSzkJrL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so1878761a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706821039; x=1707425839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U47R3tnrX6FGfSIGHpWmTF5rVj64ObwGeUEFtVpqF+4=;
        b=WXSzkJrLLBo8YfVKcsrBuqSwO+C00sqHv4+52wN8SkmmO6vg/ve0XyX4syEEryiFeb
         60PthlqmwyHj1UVt2fkW2gjabVjMXmha55/zvvIEUa4GmdmDrawFV2Ur5RykRoP4ZiZF
         wyo/bVSvoIN/vw3uPa2yEwl7NCvxpdNZ/SuqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706821039; x=1707425839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U47R3tnrX6FGfSIGHpWmTF5rVj64ObwGeUEFtVpqF+4=;
        b=EYqOtTKehJbCDH/Q4Eyd8mOm1nPZdie1Kyg+V+ul2rTEtcohMqCVdeT8NO4SJglHhX
         7MFGEYzI4HUmo210HrYgIVYx2++B7CTMOfwgpYwPI51qM4AeWvBwm2sdke0tOh+mQ0Xl
         PTtOJtm2AqFgsJ2Y+vmDKDkWQ7b/eQf4ExunTa1Ynvw0f6ShSkcz66DEkxtSuK5ymxaP
         +YGXWemtoKlcqBL+rY8Nw0geHHZOCs4vfCdozEgLIJxJVnKX9RMRh/7RRjgTCf7zmxnE
         80X5nl0xQ4UIJVZOiF/gM+NFvFbILCx8qbzxsUtdnNqEQFE535obPM3KLDxjsfv0k0xl
         jJHQ==
X-Gm-Message-State: AOJu0YxsAXr/P3uDh5dOU2EAa9MobIgb7MdbKNIjnTHggbCMFhVtWKcR
	UnRC0/xbZfIzs0E7AvqPC38fdQt1GKFx0oifIpeJndYmjIh8bzh13eTrNKdRgQrZxg/zoPlPQ2I
	jdXGnug==
X-Google-Smtp-Source: AGHT+IEDuD60rCogtAVsbZvvJjG1XbCYOz+/bFwpRkAyByPEwxLJKiUd6acEsdCekh6GD1Dk8/3JJw==
X-Received: by 2002:a17:906:111a:b0:a31:6e92:6d2c with SMTP id h26-20020a170906111a00b00a316e926d2cmr4372562eja.59.1706821038770;
        Thu, 01 Feb 2024 12:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9aP43QRwmp9ypN/iaz+OugQ26QdxkAKcP+AEiK4hfmwm99orhJGqSNdLN/ho0NNBBXerQyCcBEraktBkx6BbwOKBFjQgDmJhIzUJc
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id cw9-20020a170907160900b00a35757cbd9esm159727ejd.4.2024.02.01.12.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 12:57:18 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so1688348a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:57:17 -0800 (PST)
X-Received: by 2002:a05:6402:3181:b0:55c:d503:764c with SMTP id
 di1-20020a056402318100b0055cd503764cmr4327080edb.22.1706821037656; Thu, 01
 Feb 2024 12:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201202254.15588-1-acme@kernel.org>
In-Reply-To: <20240201202254.15588-1-acme@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 12:57:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
Message-ID: <CAHk-=wgkTKyon279Rfd_20ot9sfHmCh=t=v8GD8yHCM3Bna_hw@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v6.8
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 12:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
>         Please consider pulling, mostly 'perf test' issues, which in its
> turn are mostly related to myself having Intel hybrid systems at home.

I started pulling, but there's some truly odd noise in the tag, so you
clearly have done something wrong.

You need to fix your odd tagging process, they are normally noisy, but
this is just so far off the norm that I can't overlook the craziness.

                  Linus

