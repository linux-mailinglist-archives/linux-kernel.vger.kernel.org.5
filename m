Return-Path: <linux-kernel+bounces-141566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EB8A200A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B851F2522B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BACC18030;
	Thu, 11 Apr 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hHRm1QLg"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CC14F65
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866968; cv=none; b=M9C8McIwUZ23CwG2ag++IrXWecNPeG/EC2eHwwYfeiSUm2y2Lcv2wPjeGcmAR6N3gNL/mzUrw5cgkO4r81Zq2P1tpqicOdNcM3YxqDJ+O0swYoCRXgppIuC1gWe9eS26mEVcOQzNJk0+U9OcEO8xQp8e3QcaVK74/NH8XdPhDl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866968; c=relaxed/simple;
	bh=dkOu2O8WzCBJ47ChmxIx9bdrhdZhytLJzKX9YJkD1KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvCNPbPFAtnQE4J9uwzRZ0Ww8E6v22M20D7a6yVQ5ju5LuWHo1krc227vFjVklUIyyTQtazkngvC4MKxy9G/VFQOQLyeEWXxuIgSTHyBv89kPhh7s/BLOwreO7g51Nv/7PsZ+tEF0FaRWbNkyDs5I/2uk2RT97UCbd85DGTAjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hHRm1QLg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d717603aa5so2075091fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712866964; x=1713471764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u06VN/tWbKJg/XvyqgCGuqCQEW3Uw0o35DW++ROLCwY=;
        b=hHRm1QLgJYhN5hqPoU6wcr3zOPSMzRUcl2BFMYTFUku4q0HMJUICywNWZ5n4/FWvft
         MuoMG25eRpRHlYgFelYMvCkqYsg2aeU0eKhGtY0bwFzOEK+grEL5IZEjSDBALoYqviEC
         wyHCqwJTBlT93zw3/edJubsNxde6amd9r/B4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866964; x=1713471764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u06VN/tWbKJg/XvyqgCGuqCQEW3Uw0o35DW++ROLCwY=;
        b=hW0+GpmqruqLw564nIC8BoIpr1bZQOlGkwycusGP6LkELsj6vd1gl9/zzXUEZv+Vpa
         otgVBRoaSGFX44DsZzhEx72iGpffqEZhKUE0k6OWHwlZc8YUN0QJx7z7Y+nrmjXixYGO
         NtOJelJ6fomP+DjUszhiaSE/18zj2CZNFdN1xcir7HYfQD/pVNONWjUrHCrSs/UvrYVS
         J+79RilPMS9h2UOkY6jkxfizTvCqon2E9aJ+xXTwYGe0wfztvrLC88cI2pOadytb4qtE
         5wVjpoJzTUWkfDZ0cUhJPH7JydEipC7Rv41avyLJP2J1dGLrHyOt6UxdMEfpmZCTqD4E
         hVIw==
X-Forwarded-Encrypted: i=1; AJvYcCV5DVfiZQGuB1hiKn8Uf81RAMMHIXr66fAw4bg2dfVbawg/PfR9cDRg3hYp/BhhLCFqUigXIcAOuNHdssOISlxx5c0CcE6lP3HIjXln
X-Gm-Message-State: AOJu0YwVsTwYYvs89JlvXuhPpL4lXe62ddpxUALqHlJ4iPx0N/ReVcwB
	VdxRj8mvalEiCvoPBaxuKDBj6zDuc0c4uB5BZsG4yvOJr/cM3ls6G3Wieuqsyy35zarPTuL2sWC
	n3dlXoQ==
X-Google-Smtp-Source: AGHT+IHHVyJ8jiRxDBtoTqLyHOkWYS7CvbZesNMmOQK1+nnQKfL2kUAWxRNZebCXFenyFm3rWHVvlg==
X-Received: by 2002:a05:6512:158b:b0:516:c763:b4f5 with SMTP id bp11-20020a056512158b00b00516c763b4f5mr468430lfb.3.1712866964537;
        Thu, 11 Apr 2024 13:22:44 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id g19-20020a1709063b1300b00a519e8c27d2sm1048688ejf.208.2024.04.11.13.22.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:22:43 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51b008b3aeso21394366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:22:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWsxfyN0ZDc3NVIEKk2daOn8Eo7kmjh4G5DdwwP2es+t+87KbghXoilB9BcfepjNgjaCofkRkoXNWluSpLzLHobI6IY17FgeUv/M5LB
X-Received: by 2002:a17:907:9725:b0:a51:d1f6:3943 with SMTP id
 jg37-20020a170907972500b00a51d1f63943mr537096ejc.56.1712866963123; Thu, 11
 Apr 2024 13:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
 <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com> <CABe3_aEccnYHm6_pvXKNYkWQ98N9q4JWXTbftgwOMMo+FrmA0Q@mail.gmail.com>
In-Reply-To: <CABe3_aEccnYHm6_pvXKNYkWQ98N9q4JWXTbftgwOMMo+FrmA0Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 13:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTm-WVoQNnG933Nc3xfup-XrLWJ2d+Y4c-f-3b6ya3rQ@mail.gmail.com>
Message-ID: <CAHk-=wjTm-WVoQNnG933Nc3xfup-XrLWJ2d+Y4c-f-3b6ya3rQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 13:08, Charles Mirabile <cmirabil@redhat.com> wrote:
>
> The problem with this is that another process might be able to access
> the file during via that name during the brief period before it is
> unlinked. If I am not using NFS, I am always going to prefer using
> O_TMPFILE. I would rather be able to do that without restriction even
> if it isn't the most robust solution by your definition.


Oh, absolutely. I think the right pattern is basically some variation of

    fd = open(filename, O_TMPFILE | O_WRONLY, 0600);
    if (fd < 0) {
        char template{...] = ".tmpfileXXXXXX";
        fd = mkstmp(template);
        unlink(template);
    }
    .. now act on fd to initialize it ..
    linkat(fd, "", AT_FDCWD, "finalname", AT_EMPTY_PATH);

which should work reasonably well in various environments.

Clearly O_TMPFILE is the superior option when it exists. I'm just
saying that anything that *relies* on it existing is dubious.

              Linus

