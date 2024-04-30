Return-Path: <linux-kernel+bounces-163209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8B58B673C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400B21F230BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44104431;
	Tue, 30 Apr 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqZmaGWH"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1098BF1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714439658; cv=none; b=L1b0VgEUZidQsrm2yG2ZEsmQ95ZJ1NmcbqUcVsmNmmSc1gqi3cyWY9pFqt9oFd6AzYzaPW9ilq8xtcJxacCIIIR4gRWKMrGBAFjVQFur+ygx7nHszCYGHOMRzWVYT1iQh9EnRFlVL4D1kgJnG0cCvIMTsev3lz4skGBV9cUVFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714439658; c=relaxed/simple;
	bh=gkH+Lg8Ueli9zhejswM9/NtmbTgAa/XwjvqOds0mJm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZZOV7Q2DDbew2otx/JP95/Lby0CM6JUo+CeW1XpxYJDW6HtyCfagoLRgg0XmjzSG8sgiTJUCO3+G0PBn8h9AK2qY/NQbjgc0hXKrzhwkpHVPySJTIMzNMGmIUYAuO1zIL+L643hKP1SUkWjhEqrk0odU8vZgq57zj11ZcDLWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqZmaGWH; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so5467a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714439655; x=1715044455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gkH+Lg8Ueli9zhejswM9/NtmbTgAa/XwjvqOds0mJm4=;
        b=MqZmaGWHQoBBjcfOEueY4n6HSIzeFfqu4K3yyqylv8KouoieQ0eR5+SKBOoYHt5pxD
         siWxdVlMDwkcIR1cUlF76mU5wols0t3yg6NA7R5/zTOc3PBSU6FF0jSNGC1n4/svUy9b
         v3Yx9zNsf6qqP9T/JE57rEDqU8hXsfeCs83M2FiVwdcEtNAp2mndxQtKviJG1//z0k+0
         LYe+yzsKPgDyV5lY+CDVzUk410OgSOVn+NPf+h4C+MMcnFyI/9DavaQB5p2ZGH5Q/nU3
         p1RtDOU512BHgn5BDL858HN0TcRXxG3Q9YCu5RV2WoqzsgNoi9xThBlhSEocftcFM9HI
         kvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714439655; x=1715044455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkH+Lg8Ueli9zhejswM9/NtmbTgAa/XwjvqOds0mJm4=;
        b=Fq+ZEz1dNVfiWLkDOIK8QRtSkviWEDcXZuf5o/SMrHCfeHes57m2l+3GUs6pjK9nzp
         4ml6UOmTxhai5r+N6+TJ76Wo5YQAicS+KALlx6k5Vt4SElDY/1oBlj7S+IhT/0PzdWtU
         ByWKJu2cBdcp/aC35fE/cMsUAtNSU5luHFYO3m0fK0Sy2NrtCGx/ZxHQJ99kb0AfN+a5
         XeRPs7qQS+HQUTZQb1fpskOphB1CGwv+PDjbH21V2+Ev/jiMlpQLkJjxNkxVjOg9nZU+
         Y1LHBy7b9jVhQn6qDb3Si76ZdaiQ5zYstD/Yr6Kf9sZvyqTIJWZevTNVNiFhYGhHEniA
         jNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoI4rxDFIz76hXL2uTIRPg6zavvweyKaoqZTKcq3YzN3Q4Cs5mDBOPI0nAIyow3XDdh5KpU+PHFl7Foynj6z+fBttzZ0WsGjc/l4Mq
X-Gm-Message-State: AOJu0YxZd9rPNDAnabwcc2JB77XR42bTP0K6+Zxli8JmGQLh/ph2sCWl
	BpGpUiUwhKL26jcTVZ5IV8Y/xMADJOpcckwAPzntLONQfNf4c4I1Ropdbf73H5cQoawn6qV+ctp
	yaf+aF0aMWE5WK6pOZcMytTkE6M0VTkyNCUv4
X-Google-Smtp-Source: AGHT+IHyQmlReHcBIE7/To8XokSbs9aewY+RCRFR5RjVi4TS7xgD3iv0/LCwfJxrj6IqLT4i8VMtNsdlnx1p7ThnTNc=
X-Received: by 2002:a50:d7d7:0:b0:570:49e3:60a8 with SMTP id
 m23-20020a50d7d7000000b0057049e360a8mr58726edj.7.1714439655031; Mon, 29 Apr
 2024 18:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424014821.4154159-2-jthies@google.com> <6e028bfa-9063-42ac-b40f-cf17a81c2af2@web.de>
 <2024042547-shimmy-guileless-c7f2@gregkh> <CAMFSARfOYWy0a_iZyuh9e8++xHdAYXcs2pT1_yJaJ60tHR17xQ@mail.gmail.com>
 <bs4r3zdc52l7zfwphiycljucjb6hqcuadq3ecgipxjgs3wj6ch@7em7rhspi7j7>
In-Reply-To: <bs4r3zdc52l7zfwphiycljucjb6hqcuadq3ecgipxjgs3wj6ch@7em7rhspi7j7>
From: Jameson Thies <jthies@google.com>
Date: Mon, 29 Apr 2024 18:14:03 -0700
Message-ID: <CAMFSARfQ6XOV9QZRu0UNd3O6d68O719YfM5bgAk0eN=n=qFD-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Markus Elfring <Markus.Elfring@web.de>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, linux-usb@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Benson Leung <bleung@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Great! I'll post a v3 series applying this shortly.

Thanks,
Jameson

