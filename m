Return-Path: <linux-kernel+bounces-58790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D739E84EBC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D3D1C23D54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C464C3BB;
	Thu,  8 Feb 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEPS9L+k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494250250
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432033; cv=none; b=U/JbWv6wz982XZiJgCAv8ANkmhaOJKVtUvT2tA5NxeIAcK3qMaHELEHzhkTDdqVJiMLhzg8HgrNM0nxhX/Nl33f8NzP2aOdQdWVKtb5YX3xxbRet2ilxOzFRec7gkWGn0LDSd9O5ttHiYNXCFSPAJIN7wi2Y96rZQDLndWayNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432033; c=relaxed/simple;
	bh=WgiBKEizJ1Nr9/P0edOywoED0tE3kc/R7lk7Gr4hXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQbcWQR8H1vac0qOGrfi4fyxh9/7rD8HGarhhOUYBU3hKOh+TIBU3QuATqvnMZiNQU/b9+pkXXANFP2ntUCKUWos0sF7DiQsev/30DEBzVKMw272CPl6YL/GGH6VN05MDflIUfL/ZUTAnnqdtEzLBGOR3BzZ19KTyE0EWtnyoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEPS9L+k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707432030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ycEPqZLGpnCnzCxSi4khqVSrV3LcSojgaxf6ZNumZw=;
	b=OEPS9L+kiTNP9aA6gIUxV8nmsO9SqGDnCFwfs+7B/AFdenls6rww4mA3sXXhWXicnDcYVA
	6/J9+lS47VRkm3aA9FutvMX1C6Y5+jkZToFHy6v+6j7giWvGNaK08s8ciQyAQ5Tv2Mn8T5
	X3kP1fnQsP52EEZ0jqzI58swkHiaU4U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-jz8oIMHwMj-0HlRBcQ06PQ-1; Thu, 08 Feb 2024 17:40:27 -0500
X-MC-Unique: jz8oIMHwMj-0HlRBcQ06PQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68c53f2816dso3600986d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 14:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707432027; x=1708036827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ycEPqZLGpnCnzCxSi4khqVSrV3LcSojgaxf6ZNumZw=;
        b=kG3j+uJM76nL5mxRJmQ0+pciFtQE7emna16kclESEKTRtFjhVpbV1Q7xfr5KYG5qL4
         k1oHnfDf7hZ7TA4x8j+VZnaEcFVKZ+x8x2i32nTwVAxAQqYmxgDfp3ger0T01sFwYfzz
         qoTIeIau2VbmRt5ve2/fS0p7j3FtzjF81xK3T0awEVSyswZmU2TYEaGIyrF5Teh/eA37
         YInTbjETe1n/u4xWBUKRARPmJv7XpCXKZq2IpMoV0a6JmrbVAOwQXxqXL3Of7ZO3VZ/j
         lGWq4bRlA2S74riTXcLUyZTq7acBLV7sW7v0WIksos82zVpiU5HjYiBLUcf19e/j0iTC
         y20Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5+zcxtGIchuLDiHWl+z94fNB8a5gfVghNfjtn4F4clDXLZR6GgHXbzeE5aPLRjzl6GLZwXmc8QZQ6n8KinC2b9TEmf2sKpCrbSOt7
X-Gm-Message-State: AOJu0YxDudKJt9Uv5e3elQJHfPpLGKmgX73iRIiO7yQe3evjrbc+QaR9
	/zvplwtIcFZF+VWCsXUlD2J0pcEwiMUXbyqNOabKYl9bPtQb9LZoHv61f7kpBqcKrIJOaYSkn47
	jfs5oyRdEP1hJAFU4rXXVeNXgGk7tWk+jIXyF03G8zf5O1d+grrxbOycWIBWGyA==
X-Received: by 2002:a0c:9d4d:0:b0:68c:5d4d:d823 with SMTP id n13-20020a0c9d4d000000b0068c5d4dd823mr641114qvf.17.1707432027176;
        Thu, 08 Feb 2024 14:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVY9IMW/luM8KccH5a1J718sjNe4/VebAq7wJPEa3L5YO/q6oi3fkBE6P6MyZ/xcQrXdWztA==
X-Received: by 2002:a0c:9d4d:0:b0:68c:5d4d:d823 with SMTP id n13-20020a0c9d4d000000b0068c5d4dd823mr641106qvf.17.1707432026955;
        Thu, 08 Feb 2024 14:40:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcKABkyvg/1h3Ln4j2HcqyFpJCJb0KMDbQu/7iAEzOv6TR/hAltgVR9+04P75FiGBPNQ1uqOqHsoC5dLmP0z5QPbp0XKO+6UehmiGqkPu76K2xWEbOJuS2IF3YQs24EGfSIKqcOBthXTms0UQtUybxl9kYUyDJ1Y0lZmrc66R72o+JH589LgofwkVEQimbYfTMGd29KPSbfKEtxyPnSV+qnulT+tIh2sfTl5AK2QzX/X+4
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id ly10-20020a0562145c0a00b0068cc62f3409sm220698qvb.23.2024.02.08.14.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:40:26 -0800 (PST)
Date: Thu, 8 Feb 2024 16:40:24 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] interconnect: qcom: constify things
Message-ID: <fikip5ecdzcsud6jh5rk2kvp372atme4kz47jj47eopzasg73u@ziqlnp7zupu2>
References: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>

On Thu, Feb 08, 2024 at 11:50:50AM +0100, Krzysztof Kozlowski wrote:
> Still some things were left non-const.

These changes all look good to me.

    Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> 
> Krzysztof Kozlowski (6):
>   interconnect: qcom: msm8909: constify pointer to qcom_icc_node
>   interconnect: qcom: sa8775p: constify pointer to qcom_icc_node
>   interconnect: qcom: sm8250: constify pointer to qcom_icc_node
>   interconnect: qcom: sm6115: constify pointer to qcom_icc_node
>   interconnect: qcom: sa8775p: constify pointer to qcom_icc_bcm
>   interconnect: qcom: x1e80100: constify pointer to qcom_icc_bcm
> 
>  drivers/interconnect/qcom/msm8909.c  |  6 +--
>  drivers/interconnect/qcom/sa8775p.c  | 56 ++++++++++++++--------------
>  drivers/interconnect/qcom/sm6115.c   | 12 +++---
>  drivers/interconnect/qcom/sm8250.c   |  2 +-
>  drivers/interconnect/qcom/x1e80100.c | 12 +++---
>  5 files changed, 44 insertions(+), 44 deletions(-)
> 
> -- 
> 2.34.1
> 
> 


