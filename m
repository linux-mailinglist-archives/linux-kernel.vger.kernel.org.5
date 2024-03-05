Return-Path: <linux-kernel+bounces-91739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D88715D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0569D1C221CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7377D401;
	Tue,  5 Mar 2024 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKclpaBC"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C037BAF5;
	Tue,  5 Mar 2024 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619990; cv=none; b=hZf2YReFp2L6QErPHhBxT6O1UpcFUz6Ql47SmOMSaMNoT9IHBGgLWFpwYHV8DCEYHU7vu71hQgdA/Bc4n2E46Azx8Lj7TfoTm6i4nP4T60qIVkXI22mF5h+4udRC3RFwPa7MHgOIxt5Qk09Zh1/svKWnPtT2vBG86fE8HtVPXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619990; c=relaxed/simple;
	bh=4WcwbnvG/mxYLT7NMzyd/6RuMVuKWlNOC/ALXo4rS7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQE67PvLPSll0m50t7obH/9lQjoovdZykQFGVFT33tofyF9A405fkfnsyARTLa7LUetugHzBkaSrnR8TLm8dwibJQvvBq5f9NPa3g+LXMjTkul3UPxDniUiIXg0jJOLNLiao6ulB427OVXom+RLlcXA6aCblIYkPFUIkGvkTnAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKclpaBC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45606c8444so193562866b.3;
        Mon, 04 Mar 2024 22:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709619986; x=1710224786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqVT2JnNRbPWzcgR4c2Weugh7r6QhZGdlXDyICTLojU=;
        b=nKclpaBChcpYnHTa4e+m0ZZT7pykEe3HH1B0AzShm+O9rfNn2SuUZgybRdj1aF9E7t
         VWmCoQl9CklxNePszO2AUUDWU0lPLCaQv3vZpSrpDw69Vc8C1ZoTNDRF5vUpINA6huIj
         V0GH07o9w19lEcj+T7O3Fvw3A4jASQRu0MMMXhrfCDk8OEwX+MvY+X1FfiCKTrwjn2px
         hK3g/nCaLl0dPQxYFnRrCyOFlkYz0fCCpxqoqBX8KtIwhjKL2eh4VIo6t/ozkJWpzzn4
         EJoKdkEzzNAemj75J3Tn3HsURmW5tX994xODS8xPcRWuKRc8BFeqlgYmATT7bkggsQMr
         NJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709619986; x=1710224786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqVT2JnNRbPWzcgR4c2Weugh7r6QhZGdlXDyICTLojU=;
        b=OSaGCutDO4rYZ7kqTKuD7g4eWfbMlX0K524E8/WBTVpMM8MC0TYvHz7pJggV6PCXP3
         d5/L4J+MG3wz5dEs9OZPtfHBC+pUPeP8EHH1H5okMZJvFhGbvQUMV3EQ0ypeOgInOzPC
         w6bifJx3YPRXuitGNlDPK8mN2S9+7Lz1eb8dvHCywKE4PiyyNFkrgEqw375NZJvMBVCN
         Wuln5kvpGYXu82VaqOtAYReeEx6fR7Pl+xCmEfsf32LrQXEh/G3IuhxeJguL4SmhuvUl
         E5SEwyb1Fquaa35hdQkbAhXKkP0fauNQbYD0T6HGVy6UVItVWezq0zB5fGokyH8zLH8M
         nbFA==
X-Forwarded-Encrypted: i=1; AJvYcCV3b1GNR8FuidbUETZ/JEWyUmcGlOWGWh6riT13VUWCzgLCGcTjBL7U23STlf97HKefYTcrP81gMZeonX+Qk5uDZj3ViMBtNzB2GnDL
X-Gm-Message-State: AOJu0YwCxDcFtCGTTEXAbdiDbCmMmYBXbGpZzNdR0ZlGKLC1gJ8yJnVA
	AFilWqnrhg+/QdmtooPPSwT+olo7MO2NEBIPzDMT4DPdRjJEN+rS
X-Google-Smtp-Source: AGHT+IHZdhzjgdjNLmYhH0YtNevSSWbhslBCufGVr3vJHKdif829mn4Po1yPYIlQjpS8iJmJ3unOTA==
X-Received: by 2002:a17:906:6b94:b0:a45:26fd:f5aa with SMTP id l20-20020a1709066b9400b00a4526fdf5aamr4184411ejr.17.1709619986296;
        Mon, 04 Mar 2024 22:26:26 -0800 (PST)
Received: from [10.10.51.93] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id d17-20020a17090648d100b00a45a8193aa9sm299289ejt.107.2024.03.04.22.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 22:26:25 -0800 (PST)
Message-ID: <80745896-dadb-4fcd-9485-7a476df6de16@gmail.com>
Date: Tue, 5 Mar 2024 07:26:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Input: bcm5974 - check endpoint type before
 starting traffic"
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Henrik Rydberg <rydberg@bitmath.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305-revert_bcm5974_ep_check-v1-1-db4f0422588f@gmail.com>
 <1c13f4f7-fa02-4864-8621-bfd738546fc2@leemhuis.info>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <1c13f4f7-fa02-4864-8621-bfd738546fc2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05.03.24 07:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 05.03.24 06:52, Javier Carrasco wrote:
>> This patch intended to fix an well-knonw issue in old drivers where the
>> endpoint type is taken for granted, which is often triggered by fuzzers.
>>
>> That was the case for this driver [1], and although the fix seems to be
>> correct, it uncovered another issue that leads to a regression [2] if
>> the endpoints of the current interface are checked. The driver makes use
>> of endpoints that belong to a different interface rather than the one it
>> binds (it binds to the third interface, but also accesses an endpoint
>> from a different one). The driver should claim the interfaces it
>> requires, but that is still not the case.
>>
>> Given that the regression is more severe than the issue found by
>> syzkaller, the best approach is reverting the patch that causes the
>> regression, and trying to fix the underlying problem before checking
>> the endpoint types again.
>>
>> Note that reverting this patch will probably trigger the syzkaller bug
>> at some point.
>>> [1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622
>> [2] https://lore.kernel.org/linux-input/ab9d758c-3ce9-42f6-99af-877055a589e6@leemhuis.info/T/#t
> 
> FWIW, these should be Link: or Closes tags, as explained in the docs.
> And there is a better lore link. And there is the bugzilla entry as well.
> Hence...
>  
>> This reverts commit 2b9c3eb32a699acdd4784d6b93743271b4970899.
>>
>> Fixes: b516b1b0dfcc ("Revert "Input: bcm5974 - check endpoint type before starting traffic"")
> 
> you might want to add them here like this:
> 
>  Link: https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622 [1]
>  Link: https://lore.kernel.org/linux-input/87sf161jjc.wl-tiwai@suse.de/ [2]
>  Link: https://bugzilla.suse.com/show_bug.cgi?id=1220030
> 
> In an ideal world we also would add a "Reported-by: Jacopo Radice" before
> the bugzilla line, as the details in the suse bugtracker apparently is
> public, but it's likely better to not go down that path.
> 
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Ciao, Thorsten

Thanks for your comments, I will apply those changes right away and add
the "Repported-by:" tag as well.

Best regards,
Javier Carrasco

