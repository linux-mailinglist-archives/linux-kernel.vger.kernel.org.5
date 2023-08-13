Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0191877A4E0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 05:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjHMDks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 23:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHMDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 23:40:45 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E368A7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 20:40:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso48642301fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 20:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691898044; x=1692502844;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s20/fa6pOItizfS6NtS4wAstYf22/BRNYrkUfmWWaE=;
        b=Vk/2X1E9ffMheQoiqzvaYL0j2KaQyo4bBXGeCo6BiQymKcUFdl/UsjMS62SvHg73tN
         7GNZPjFyKyQ/GwBYWiIc017QJ7Ao5owdrvCzUTeVGUIV19odPRJmc89VemiZo4VdzTjp
         FAasDSRSJVR7rANpczvwjVlDYOZSX7Lg0TamU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691898044; x=1692502844;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s20/fa6pOItizfS6NtS4wAstYf22/BRNYrkUfmWWaE=;
        b=MgIHlWjIxRIzpcbC49Hkiam/611w9h4lMPl7jChFsVq1LnTth35ip4doW31R7Z4Wil
         IYEQF+d55uV05LFukIbDeCKj2LHcGUmvBoDv/KgLIXOq8X96Fw4EGKC1IpUtfjw8ypGZ
         k450Fy2vISeKL9WAb3psihgbJmacFldpD0I6EGo7yuJZ/4dqCWuFZATcksPowochHsdq
         2HE2u8O2hi9zSV9uKgIHbPQ6cAUM0KyZt4gWmSUHtbHkgObOC159nwAsezhbxrJjCxx9
         zDaA98uxAakTN/3fMJtLg/2m5iBGrRcuYdurNL3lCGIZEjkDlOItaoN+3qGgp6H2/QI+
         bDvg==
X-Gm-Message-State: AOJu0Yy0T++0iJZox3GXAuudP8PQ4BKwBdRHIJ9bp9wfaHJwrdBo/g5E
        DTtIQna6lxZYrXYZ77SCAI0DvE3QTw4Jn2l1hjQk/X3hecSyJCG6
X-Google-Smtp-Source: AGHT+IHa/peB92ZPQ+U7V/JGXppu8EHr58ntlRookqhkweBW0+nP5IpGcD5uvfbNnmK+nJW8g2xkP2G6Qpmeky3NeK8=
X-Received: by 2002:a2e:b162:0:b0:2bb:71fd:2dca with SMTP id
 a2-20020a2eb162000000b002bb71fd2dcamr343295ljm.52.1691898044415; Sat, 12 Aug
 2023 20:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230813033737.3731290-1-joel@joelfernandes.org>
In-Reply-To: <20230813033737.3731290-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 12 Aug 2023 23:40:33 -0400
Message-ID: <CAEXW_YQyZJDQg=hnUdtKfU+m_BSMgPeRFSpYj77XCoNjR7faag@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Copy out ftrace into its own console file
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:37=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: Joel <agnel.joel@gmail.com>

Sheesh, 'From' got messed up with my other email address. I can resend
unless Paul is OK with the patch and can fixup my From (appreciate the
help!).

 - Joel

>
> Often times it is difficult to jump to the ftrace buffers and treat it
> independently during debugging. Copy the contents of the buffers into
> its own file.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../selftests/rcutorture/bin/functions.sh     | 24 +++++++++++++++++++
>  .../selftests/rcutorture/bin/parse-console.sh |  7 ++++++
>  2 files changed, 31 insertions(+)
>  mode change 100644 =3D> 100755 tools/testing/selftests/rcutorture/bin/fu=
nctions.sh
>
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/=
testing/selftests/rcutorture/bin/functions.sh
> old mode 100644
> new mode 100755
> index b8e2ea23cb3f..2ec4ab87a7f0
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -331,3 +331,27 @@ specify_qemu_net () {
>                 echo $1 -net none
>         fi
>  }
> +
> +# Extract the ftrace output from the console log output
> +# The ftrace output looks in the logs looks like:
> +# Dumping ftrace buffer:
> +# ---------------------------------
> +# [...]
> +# ---------------------------------
> +extract_ftrace_from_console() {
> +        awk '
> +        /Dumping ftrace buffer:/ {
> +        capture =3D 1
> +        next
> +    }
> +    /---------------------------------/ {
> +        if(capture =3D=3D 1) {
> +            capture =3D 2
> +            next
> +        } else if(capture =3D=3D 2) {
> +            capture =3D 0
> +        }
> +    }
> +    capture =3D=3D 2
> +    ' "$1";
> +}
> diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/to=
ols/testing/selftests/rcutorture/bin/parse-console.sh
> index 9ab0f6bc172c..e3d2f69ec0fb 100755
> --- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
> +++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> @@ -182,3 +182,10 @@ if ! test -s $file.diags
>  then
>         rm -f $file.diags
>  fi
> +
> +# Call extract_ftrace_from_console function, if the output is empty,
> +# don't create $file.ftrace. Otherwise output the results to $file.ftrac=
e
> +extract_ftrace_from_console $file > $file.ftrace
> +if [ ! -s $file.ftrace ]; then
> +       rm -f $file.ftrace
> +fi
> --
> 2.41.0.640.ga95def55d0-goog
>
