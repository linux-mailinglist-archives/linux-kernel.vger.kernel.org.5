Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE577B73D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjHNLDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjHNLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:02:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8518F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:02:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcfe28909so541533066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692010966; x=1692615766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LT0OaCPd61k3/xuFtTRuhfa3SWYpqLwDHB86rSkZVfA=;
        b=ij7hW52gui9yvHzBS30YckIi9Cf3Ea0ytH2mgr35CspJvPiNTFdCykOo5Wj+CrrU53
         Bqd5SDC3f040JB4H9MHBvYYC30xmKbWh30YKnjOL2bHTW/g36d3zXmbr11IVPgNOMTTG
         qOa9l178XWHWCW7rs61cx0zL6lXYMNazEwU8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692010966; x=1692615766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT0OaCPd61k3/xuFtTRuhfa3SWYpqLwDHB86rSkZVfA=;
        b=RJU8jTwYAyHqvyKgCARwXIVbAzh2OAiDW8UirLgCR2eSRHcuU/kEcp5wnrNYa5pp6a
         niH1Uz7uSeN3IrA14H2UE/vq53x6LXjNQbbNlGQwWMg2O0EZkCL1ysz7HOvVlGQWcnQd
         hIdaxKF4pdBzQurCogtDo7S0XYFSIZkWTppdC0RJdIiblKYJLVnBF73TI4x4vi4xQF8+
         MzCyyLyHUhyptFuesy2qxZV7gm84ZhkpRWpTSlbI4CGMkKndSh4VHLbikRpq9YfR5wGB
         KyUW89QfGiIiK3835PECGj05eOPAyodtDaxNaYBY91ttgrBIWJffTeuMLPPEle34FYDU
         4hdQ==
X-Gm-Message-State: AOJu0YyW12QoElalQ8YewmIGbXyfdO3dE4gOpIa0WAz2i/itKqJWh/2x
        glWZiVx28Qac+1K5cq5VbOD6bqjTfyapHRJxNcKG/A==
X-Google-Smtp-Source: AGHT+IGAB+8G6IRPlsulIO426V/9zMh3Xv+vnE8M/rUzZ9o9urHDXXVoPA0Mls3ByEUcsReaZOD+ymkaSJO4fHWFd68=
X-Received: by 2002:a17:906:5dc1:b0:988:8be0:3077 with SMTP id
 p1-20020a1709065dc100b009888be03077mr6644363ejv.31.1692010966572; Mon, 14 Aug
 2023 04:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
In-Reply-To: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Aug 2023 13:02:35 +0200
Message-ID: <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async fuse_flush
To:     =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 08:03, J=C3=BCrg Billeter <j@bitron.ch> wrote:
>
> Since v6.3-rc1 commit 5a8bee63b1 ("fuse: in fuse_flush only wait if
> someone wants the return code") `fput()` is called asynchronously if a
> file is closed as part of a process exiting, i.e., if there was no
> explicit `close()` before exit.
>
> If the file was open for writing, also `put_write_access()` is called
> asynchronously as part of the async `fput()`.
>
> If that newly written file is an executable, attempting to `execve()`
> the new file can fail with `ETXTBSY` if it's called after the writer
> process exited but before the async `fput()` has run.

Thanks for the report.

At this point, I think it would be best to revert the original patch,
since only v6.4 has it.

The original fix was already a workaround, and I don't see a clear
path forward in this direction.  We need to see if there's better
direction.

Ideas?

Thanks,
Miklos
