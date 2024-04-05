Return-Path: <linux-kernel+bounces-132636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD8899790
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8681F231F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FAB145B15;
	Fri,  5 Apr 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkjzBlKG"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFA14D299;
	Fri,  5 Apr 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304764; cv=none; b=BjgecALpQHm58C5bfAbPkth50E8MpzLgZ4HfS+JxSqv6ztLz7UUMshnIq6jngG25n/ZKUzMP2VlzrxjKjcd+2Tth5AgazitlnD05SJ18lClDV0VXXrAldW6AUCU+tfjeo3hzzNzJ8rc0eruGVY42H09IzIFpavwC2gKXrjcs8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304764; c=relaxed/simple;
	bh=GXiP+uDMkTskhfWyyo+BigOGT7Sp0II1yXElavMKWW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXtAGKOOnewC6QLZRLGg72yie+GxtzapDkZPAES6WZUOBFod773Gl7bpQMtslIyOz1MeOUXzACw/ymtKoAeNb0XjxM6kVt6Pdo2/ni6l8dHo4DQ1qBsMOeYTKUC436ZpcR8SBK9DPS3dmLiBYp93eABSOsIZ4hceK76AjOojJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkjzBlKG; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6d063e88bso1190636a34.3;
        Fri, 05 Apr 2024 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712304761; x=1712909561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9c3bDJ3ex6PwLSEvWrW5Tb1qMTVJqP9dhel5KI3lZ8=;
        b=lkjzBlKGmf6+x9zY737A9aeQbYxU8A+inm6CfAJ/0LX/dG4vm38coPWyANJYlWbjZp
         6bxMdcPTZLfMYZh61umDZ38lXyop9JP+yTXYg4Ph+1Hh8TVO7Sd3odhfw0lchnqrRGaA
         m4Wa7PVlSjLexTJpvYrZ10Dewu9WjQ5/rBnk/2SIcn6Ljk42F14p68QQhBev/yy6odTD
         uPNlqjDgttZUNNNyqZeYn5muLz9/o+W/OOurOg8V5inteGNKzkgxcSqW5grdtl6Bbv5s
         l68B+2plcvnyqpiqOPdzso5s4O4FzgwtPHWJRn1caAGfUTaAbd+DztHw0+v5T5iN3ho7
         VInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712304761; x=1712909561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9c3bDJ3ex6PwLSEvWrW5Tb1qMTVJqP9dhel5KI3lZ8=;
        b=QPE0RVHeDy4HkLwzol2W/fJlYcOoHN4Qpv6OC5q+tpaCt88D2Hlu3QP8jypGowXY47
         EySyMFBRDzcc3Gd7A44TNOKAzyUDHU1StbOipCXIHFL/GQqZzh458g/OoUL4r3KEVsXl
         LnRkkTerjMlhQq+y69Er0ZhM3/xzvEc8aosqoqw6/HMldwZU9D73VxJTGVHvBdCfLtXy
         760hbeRjhAOCd1jx6Ept6IrShvQZrqZF6l63iSOC51r0lGXmgaCbRWw0MC6HLIE2NmFp
         xH6Ijwj9RXEXFyFUzG9lHswPVD19MkGw56pqzrwfHRIQa5rX+KXtnehvEsrFgbFzwbsZ
         ysiw==
X-Forwarded-Encrypted: i=1; AJvYcCW0E1KRHhSRIr5baPWhcUfZP3IPbtcWftCApyEMbO+QxbJFR1m3b8z9gPjuUF1obAP+sFRx6t2OtCOLt1VrHg/7d8xOJVojKRNCcfpOaggRZVrzc09Na1L3oEJlxU30PiIzAxJF4PaxDii0+yxlSZg8PgVVSXl1lCA4f0z+HfJXq9XnpbJolg==
X-Gm-Message-State: AOJu0YyW0l7KBGrzgNTCJjIh4Yq+Rxz8lfOuApq/uGWv4upQCEDt6wpV
	HKj+JFNy/dubfPhHdHwAinLsmh5cg+uj8Xq8VThK2EndYPUlRTRVY7FbvRPB6o1WUJ4v2U7C1O8
	MalYaMGaXpGZ+aW+g68pQUbRjCow=
X-Google-Smtp-Source: AGHT+IGJA4qSu/BgqwLCfgWb2f5ZtBV+ihPgrrMO/9aw/0G4Sp4ahheWhLM/jo2bbCVdOazrR+RuAXv6TsavrH9MEDs=
X-Received: by 2002:a05:6870:7683:b0:22e:9504:9600 with SMTP id
 dx3-20020a056870768300b0022e95049600mr539457oab.55.1712304761495; Fri, 05 Apr
 2024 01:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327054911.43093-1-animeshagarwal28@gmail.com> <Zg+tgFFDkwLvWgLv@gondor.apana.org.au>
In-Reply-To: <Zg+tgFFDkwLvWgLv@gondor.apana.org.au>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Fri, 5 Apr 2024 13:42:29 +0530
Message-ID: <CAE3Oz803YoKiWqf1zu_3E1Md4pADjR00aSr=twzdKtD_-a_O4Q@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:21=E2=80=AFPM Herbert Xu <herbert@gondor.apana.org=
au> wrote:
> Patch applied.  Thanks.

Glad to hear. Thanks!
---
Animesh Agarwal

