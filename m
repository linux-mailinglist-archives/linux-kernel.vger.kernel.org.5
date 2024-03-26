Return-Path: <linux-kernel+bounces-119781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76988CCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7136FB26B32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A313CFB3;
	Tue, 26 Mar 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EsFc3yX2"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24213CFAC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480695; cv=none; b=bVYkiHJAFQd0YSuzNYzBDSBAYdU0iafY4qqbQwBenrg5xKGf03FEBY6dx7JTlvxX+WitQj8qq7O0yvvcUFQVkt8kIOjwvsENp84NqowfP5ev+ufLjweKAF2KdbwQNDbQA9Ns3CWZQbIB0Zpx7wpO11RLIvzV9iDuZl6cf0wkh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480695; c=relaxed/simple;
	bh=c2enpOGs0X4T4rjqA7ge5hA+2N1P5nMY1p+BtQwpvCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHUFjooTdtxx/MPagyWr7DD7ODEcs1Ld33di9TI+YiYQlDC1IuipGYabKfXHdHLeFnRXHzF+KRVzjw5J9bIPp0lJyf7e31k63MQEdCOkjuszitJFRxerd9MsoV1CsQh7KkZvr6Cupf6oDuABlO1dKBuAxqv1eTcv10DHxe9gqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EsFc3yX2; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso5593992276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711480691; x=1712085491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaxPwfF6pcSWzIoXPt3G+TXmBRyW+5V+y3uoFizWf9Y=;
        b=EsFc3yX2r7LXKbaBWPyMnOKWwGmNXgiF8lUhJDrsdtAHd5+ZBWiouzr2A7jkRmkKNQ
         9ClNxKBDdC/fPj33Qnlpd1eDYYs371Ie61f/TuEx3H9IZlAbr0jtD8FSAXrB4w/ppFJa
         Vq86UYpi7/bHFeaZZMJ4AHSS1mF0EcPeqk8taxaT/uyc9g//TJAMnFPD0mGc8IO5TSC7
         sLRlKR7QhxD3kqhV1zFZTECgdtukh0zOlCuVxWJGcZFkOqEBYC6X90SikoCn6wUDoXB5
         slUPTqcvaKDGa9WgteMAx4JqaOY/Pq6KthxnAQq5BAjodshJZzX5hC/FP7CHn0Z9jjWa
         hJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480691; x=1712085491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaxPwfF6pcSWzIoXPt3G+TXmBRyW+5V+y3uoFizWf9Y=;
        b=Ji5aVLioNLmn8kaLmIowl61eG5NAzPruyBao3EpJ+ds+1OOJZ/81w84bc8xJ31f6Kj
         2cFFiIOFM3wlSlouSMxbcWEnAeuLeyxFPe9NW1CLP7B8KbTe8Ibp81f+9a6TQ5wFCd5o
         zacUNz0ZgIQrr9NZVXb9dC9sjUZoM7bOb75onrA7UvZSNFqC7HidP5/FfD3QsgTQbjaD
         g4vPDfwPzVr0+AnzFF4AlvqMjqBJLCFwhAH2IwY9n5HR/8zK/Y7uYDqxCOuRmK34ZVrQ
         uyRbkAleufYl66FuZS5O9VBRZYpyG839h5BAXgRnrrcDDnhjMKX7MFwRBo60G7+vG1sK
         oWVw==
X-Forwarded-Encrypted: i=1; AJvYcCVTNCRLpRNZvs5va6DOhG9qWLFaiMqewgx3Ty1JUet+G59fBn2ibpa7r7W7A+OLXmcrJ0v28EH0/Y+N9XsoNXVnYCf2Aq05ptHxYWsY
X-Gm-Message-State: AOJu0YxirojyKbbSBxBM15c4z2++SvJ/3JWB91L/r1+YQsEzY0zZZfpn
	JHI59/Rafe/993iZ2lOuULxsDGFyQJsO1Enm/gE2xN4335vXlDtZIHn7oXem3IZ3+xVCPmw3z4D
	BPtVePv4vnDIixrBK2Byj1gThjH+UgtW7v0Pj
X-Google-Smtp-Source: AGHT+IEcNPIscIUrckKDg5If7x3ZclJg0Hn8ehLPXdqFB6Huk7CPYW+4wqalcC+NaGkyWtv8nYTfzs1Tr9JJsquzDkI=
X-Received: by 2002:a25:bc87:0:b0:dd1:3cc1:5352 with SMTP id
 e7-20020a25bc87000000b00dd13cc15352mr1736980ybk.15.1711480691209; Tue, 26 Mar
 2024 12:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315125418.273104-1-cgzones@googlemail.com> <20240315125418.273104-2-cgzones@googlemail.com>
In-Reply-To: <20240315125418.273104-2-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 15:18:00 -0400
Message-ID: <CAHC9VhTOmkpZu-zUEcvWJxLVHwoUnTcPxhBexs1ZKjr_LRKx_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] yama: document function parameter
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 8:54=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Document the unused function parameter of yama_relation_cleanup() to
> please kernel doc warnings.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/yama/yama_lsm.c | 1 +
>  1 file changed, 1 insertion(+)

One small comment below, but otherwise looks okay to me.

Reviewed-by:

> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 49dc52b454ef..f8e4acd41b72 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -111,6 +111,7 @@ static void report_access(const char *access, struct =
task_struct *target,
>
>  /**
>   * yama_relation_cleanup - remove invalid entries from the relation list
> + * @work: unused
>   *
>   */
>  static void yama_relation_cleanup(struct work_struct *work)

Should we also take this opportunity to mark the parameter as '__always_unu=
sed'?

--=20
paul-moore.com

