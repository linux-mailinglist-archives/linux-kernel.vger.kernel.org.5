Return-Path: <linux-kernel+bounces-55006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786884B62F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F20288765
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC9130AF4;
	Tue,  6 Feb 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5OKFycE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F93130E2E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225450; cv=none; b=n2+OXn1WpyxYHCYkLrf3fQ/qpHPb8nRfw7FzAAxJpP4t7raw9tSw6E/ycpo3ItOmpRJTpKwjqZJ12a8x4zd+nyPyWR3aBVcqX2fpekJORhcXBHRe7TEUMI8QOTzMobtQX7cJsGRA1o/hGk/zQjxqbIuSxNAKIRXRrB3BIYW3wak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225450; c=relaxed/simple;
	bh=4i3zRtRM11Cg2KpgT0q+2//W7pMM2xt1zWoak+1GerU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cDJec5Yj81BfziCOOeL7PnI4XcKz/8iDr9BJ2jzjB5nOCVCUmPVW2BIJTGaerjuZs4hQB9vyPB3DECKRmxTk3d8EoOWeDEFUl/VSNOvl2fZ4SXHGqVANyG+nktcYvDJdo8I76TmvzQqxSkMNWc04gDRRbPKrLMUdlb9DQ77spgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5OKFycE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707225447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i3zRtRM11Cg2KpgT0q+2//W7pMM2xt1zWoak+1GerU=;
	b=c5OKFycEeK9v1xhdI8NC9KPHtOa52uJ0PRyj9tZvC8mrWv6ZMGAiyz4vXQJLppCFWKmdac
	4UuEmoloNKzyxeLhKLQ9P2EWP6EPUpecIE20S16sNqQtKV2A5ruDbmdT2noxY5KVxQNVLu
	66NveEsXgKraWNYduwh35iY3rPHU9zY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Y3D3Sr9TNKyLFHJFVFsXHA-1; Tue, 06 Feb 2024 08:17:26 -0500
X-MC-Unique: Y3D3Sr9TNKyLFHJFVFsXHA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78319f64126so676154685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225445; x=1707830245;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4i3zRtRM11Cg2KpgT0q+2//W7pMM2xt1zWoak+1GerU=;
        b=epaABqJSaW4Pt95KR2dzMMI2G1OSxFtSORsZn+A6/m7eyeVEDT97U8nSVNPhdAvzae
         ZZU136cbmbsKb8IirF49DReuxklaUlPb4NYMGXzE3jfF8UaoGW09J38UjhblqYcfTAzb
         yDK2nZExiimjVrzO2xUf8CkjLq3pFBSA6yKrArcvkPP07l7AJnFb8+u3g3NBafRBtrMz
         VgPe1UtPyBm32D++VTzstHYUPSjiVpQ/JImTiV9Dn6HBRqZS76v4llLlXZuKLzolGmle
         komo2AXPc56CgcZ1wCD++fxKLCoKXx4evh0w3O/wtld8bdw2gRE5HJZSy8CfHCGgNa0h
         NTiQ==
X-Gm-Message-State: AOJu0YwQDlOi80zH91oUzJtDBBvBaj0Ju6PpvDUgUWqF8WCaZgXgyhlr
	ggf+J+RyAEU8V0cJu+lGOAbPpMVRktNQuuOS7vJk1ccGRYVgi/1Mx9DrgDCVtjcOF13syxaVuPH
	e4fJuZr4gqy2zJU9+7jwVkHJGTxc+aOreLuE4BM9RBnEx9k9H94fLGytztdoK1g==
X-Received: by 2002:a05:620a:4d3:b0:785:60d6:36f7 with SMTP id 19-20020a05620a04d300b0078560d636f7mr2634908qks.69.1707225445712;
        Tue, 06 Feb 2024 05:17:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENMrym6fMHLO/71HKMNXgxwio0b/TAbj1n6jotgc+hsRZhjLd6Sj7rEbTesFS9dlqqpsP+rQ==
X-Received: by 2002:a05:620a:4d3:b0:785:60d6:36f7 with SMTP id 19-20020a05620a04d300b0078560d636f7mr2634894qks.69.1707225445464;
        Tue, 06 Feb 2024 05:17:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0IH2H9+nXjZ1Q8HRdi8rqyjYN++D0V0oiE0yASIfA1mJeoL3phBfHCPsaJWS8UL2wEQp8GyXKWAixT5//NtDlUxuB/KQ+47QSP8B2gJ6NWedFvPBpfHTnPRnMKqKRwJZArnwwtQtLeSnoedJkjzWMZPhSYstCmucHNtehR8NEcUDds+hLfFJrJS3UHNgPRKND5VhBmCEqWb0jBhWRCPrAwP2sFKiTkFq4RbX5jqi4Yyo9kPsT9LQQB6rftXJ2nnDIqIfAARhEFxaxNsmcb+6jjQRpuD+TmdI4vcXw+khLLeCxR/UQnHLRr+CJiJo=
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a11-20020a05620a02eb00b007856bff53d3sm880694qko.54.2024.02.06.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:17:24 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 bristot@redhat.com, kernel-team@meta.com
Subject: Re: [PATCH v3 2/3] sched/fair: Do strict inequality check for
 busiest misfit task group
In-Reply-To: <20240206043921.850302-3-void@manifault.com>
References: <20240206043921.850302-1-void@manifault.com>
 <20240206043921.850302-3-void@manifault.com>
Date: Tue, 06 Feb 2024 14:17:22 +0100
Message-ID: <xhsmhbk8thgv1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 05/02/24 22:39, David Vernet wrote:
> In update_sd_pick_busiest(), when comparing two sched groups that are
> both of type group_misfit_task, we currently consider the new group as
> busier than the current busiest group even if the new group has the
> same misfit task load as the current busiest group. We can avoid some
> unnecessary writes if we instead only consider the newest group to be
> the busiest if it has a higher load than the current busiest. This
> matches the behavior of other group types where we compare load, such as
> two groups that are both overloaded.
>
> Let's update the group_misfit_task type comparison to also only update
> the busiest group in the event of strict inequality.
>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


