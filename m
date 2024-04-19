Return-Path: <linux-kernel+bounces-151832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A38AB487
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0124DB22880
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC613AD28;
	Fri, 19 Apr 2024 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzc9w3BP"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D612E1ED
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713548811; cv=none; b=TwxNqeFkIATpuJVOGGztGjaHrD5ojm358hJZvYh5nUxXHpAfakQVoT5EzReCWMMCIFNeBokTW4lBWQ4wib0/MjAcS2NgLOxQOE8qoUI7INX30KrqzkBLegsPXsO14CIdqv8l1zNc1aojSAgOM63K9OcEoR+6wRjZxZo+HPHPqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713548811; c=relaxed/simple;
	bh=KjvnBO3Gqs8EFbhdDBMBxk/FXGLnq3fyHfPjQ6a66YQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AhNsrq9GLb1CmabETJwANKrHh8C/w345m/dobxzWk4Pn/cZoZrz1HmXEa8C0XregSci20Ud1owZ6sCSe8e/87TJd9ewb1aOEJjQbEAwv0rRma0ylTvIiujWupwoWtT24otg1R1+enmGy/x2DVk3TnihngqWSAFnNFxvMH0F2pAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzc9w3BP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so1401582a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713548809; x=1714153609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WTU4zPwpzH5hnnSlGgs786xRHV+uI0ZkSdLbqcw+BRY=;
        b=Zzc9w3BP6YBtcnyVVmFF6YmOjTpCm9CzfCSTWo9C/HRRkrpFphtOh8RRa18LtQdaeq
         mf88BqZOV7QMtNLA711V4U6hNSoBdFmRm4bKbc2ZGh8z6f4ipzMLPM+byl4i6nxaoatc
         SV/qn2SIyaxnr3v136Gqz0FWBncx+uxEITIiEV3sFQzvWfRYFSV8qPgO7nNOEebu9ETZ
         0dBmxdmVCzViHx+4m/EknC2sPod77VLeIn1ezjHT69/6VQlFnOfY6rxLgwC0Kp4hSIU9
         g+u4IoB+smR9KVK3TV3cCxa29L/B8SKY6KR9bhq6LcM6dxPEjkEjPD1q5afz2DAcbWrZ
         pCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713548809; x=1714153609;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTU4zPwpzH5hnnSlGgs786xRHV+uI0ZkSdLbqcw+BRY=;
        b=oxwbmo/ZRaUFrawv+bjr5QwSdUlQJ8+xCxCCNC/LqRyJ+JgVhFrpC37hCq4MiRCE33
         JtabV6FOsqyTldpycm4QIVvJDMxLqnaOC5kZD9PayaoFEi4GStNdU35TGWFKH3f37IIf
         +QZwR6N5Lp7oK8NBPmLSqwWUGybfRYAZQ3nuLdQwWFJR199H5LpXk2mGsm/Ui4NKZJvw
         S/pK4ekE+puTzTv8SR/H45TNLdf4IU+bjlOVE/1D+9s4dWCMwkkSvtD29ufmSQjgB9y5
         G3mlqCoMQVsPmBZLH7btWEl0zNkVey0T0dR8Q7CIovhB0nVAeNUGL0Ot4evmt9Hh345S
         41rw==
X-Forwarded-Encrypted: i=1; AJvYcCX3D8P5GUDFyLr8euUfso+FAhrY8ZzuIvGpETBtlDR87NO1FWx50PVZ5H2QbmSMqxLMKT2D3n/UgBsxb4if6xh5IS67x0nA96Pmry5A
X-Gm-Message-State: AOJu0YzUGdwVAyPq0MiBLJb2R5WTeGuWayyYV9tHl5bLSQFzfHsydbgV
	6TPvJG5gBj+s31nH60kBMpd2PCIOln5oNKGpN4Jx3sJFMmSKRCJDvrJgsRM2sFFwon3wPJl7VL6
	HQpP1hMwt5nrD8J0oSOZKA+I3yNI=
X-Google-Smtp-Source: AGHT+IF9CjY3KLqE6bk9u4LeWgvLLphSfaeuyElxCLXHyI4iSQfm8I8iO4hAG0kYOMVcOjuFOMMo3nxlIbrHbiD/S28=
X-Received: by 2002:a17:90a:fd01:b0:2a5:d313:4d3f with SMTP id
 cv1-20020a17090afd0100b002a5d3134d3fmr3313984pjb.34.1713548808937; Fri, 19
 Apr 2024 10:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Fri, 19 Apr 2024 23:16:37 +0530
Message-ID: <CAE8VWiLErhCkD9w+Rbh8mTnRQs-4iJDBrWdVXXFFFDQ3yeTaLg@mail.gmail.com>
Subject: Re: [PATCH] drivers: use __free attribute instead of of_node_put()
To: vincenzo.mezzela@gmail.com
Cc: gregkh@linuxfoundation.org, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

> Please fix the subject line to be "backlight: <driver>: ...". I came
> very close to deleting this patch without reading it ;-) .

Really sorry about that, I'll fix it.

> Do we need to get dev->of_node at all? The device, which we are
> borrowing, already owns a reference to the node so I don't see
> any point in this function taking an extra one.
>
> So why not simply make this:
>
>     struct device_node *np = dev->of_node;

Looking at it again, I'm not sure why the call to of_node_put is there in
the first place. I think removing it would be fine.

I'll fix both of these issues and send a patch v2.

Regards,
Shresth

