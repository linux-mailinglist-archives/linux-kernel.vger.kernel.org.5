Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3177C335
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjHNWD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjHNWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:03:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF61703
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:03:37 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so72981741fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692050616; x=1692655416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cniOtjZWj53zg/eiRRp/dSrOPyO3CFo1nAvkSyP4EM=;
        b=pmvfmM3gj6ksUscWqmpYGDhl4HxoJJdYQtY5So2ofJuljXP+VTsrOA3tdQEUFXonxw
         eZFsJt6tU3BSJJFzLYOKrbFb2kE/SyHYTfjFDPjuhzK7QyaeKtUOGHXic886fs2aFjh9
         0XvLSsCdpwq0a5fvyrop7ezKcD/4/yWR75MS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692050616; x=1692655416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cniOtjZWj53zg/eiRRp/dSrOPyO3CFo1nAvkSyP4EM=;
        b=UylXjvyUYv5AdBnD/KJLiaH/gzzoXwrgXL8q/ZbwYnmFWkyAHVTOYr3V9SA5ItyXuq
         Wno28+hBVzRFwzT8kc/WNSMknVbI2jMzXsgfZ5pi2CPcO9tc+X8NzEZUaiv50JT2wUaB
         kSJIzyQlHmjBNRnOQkf1UstWnwCYvWrpi/ajAkp3QOAzmR2IQK0i77LFpCXEV10yReN6
         GrYaSOcnn0Kl2waOI12UK7zBq4wYTY0L+92oj5mAgYTCkJVwo7SnhX+ZmsoPCVM4T38j
         vJzpRHy1sGVTLjBfzBPIqbAgsvrJjUQdZot8xz+AFGU7v6HG2QMPJ8UvpDz3ZPYGp+kz
         2LRg==
X-Gm-Message-State: AOJu0YyeVDDQxjn7ppa0RV63MPLfjiEw1tHmuUON01yCh+tUsxTI4Gop
        YbAUiGMUlZs02EyuQ9koQR/nHIDiAe3TkUAnTr83R3XELuknVoV+
X-Google-Smtp-Source: AGHT+IEg3Fhy6/NLNNkYLS84Q5iKI6HBf+PqSKgF4UylqPyxp+o2yyIuzOurIeh+KFDMtLLI7+UrZS1B11iUbwGrafU=
X-Received: by 2002:a2e:9790:0:b0:2b4:75f0:b9e9 with SMTP id
 y16-20020a2e9790000000b002b475f0b9e9mr7878579lji.10.1692050615602; Mon, 14
 Aug 2023 15:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230813203602.GA696907@google.com> <8f952ce7-2122-45a4-82a3-a4e4dcd85ff4@paulmck-laptop>
In-Reply-To: <8f952ce7-2122-45a4-82a3-a4e4dcd85ff4@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 14 Aug 2023 18:03:24 -0400
Message-ID: <CAEXW_YSr2Pg8cw2zrYaoRn8DQgSzM=7DhsPeO8=MMdsA6tN0zg@mail.gmail.com>
Subject: Re: [PATCH v2] rcutorture: Copy out ftrace into its own console file
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
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

On Mon, Aug 14, 2023 at 5:27=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sun, Aug 13, 2023 at 08:36:02PM +0000, Joel Fernandes (Google) wrote:
> > From: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Often times during debugging, it is difficult to jump to the ftrace dum=
p
> > in the console log and treat it independent of the result of the log fi=
le.
> > Copy the contents of the buffers into its own file to make it easier to=
 refer
> > to the ftrace dump. The original ftrace dump is still available in the
> > console log if it is desired to refer to it there.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Queued, thank you!  I did the usual wordsmithing, please see below.
>
> I also fixed up the indentation and spacing.  I don't know about you,
> but the initial format made that a bit hard for me to read.  ;-)
>
> If there are multiple ftrace dumps in a given console.log file, this
> will concatenate them.  Is that the intent?

How would you have multiple dumps, do you mean from subsequent
(re)boots? If so, yes I am OK with that. I usually look at the latest
boot attempt.

I was also thinking of us stopping boot loops. For example, if there
is a kernel issue and the system keeps rebooting, it will run forever
in the boot loop silently. It would be good for monitoring of
console.log and kill the test if the console.log is acting 'weird'.
Also it would be good if the console.log had a huge timestamp gap in
it like the TREE04 issue. Would such changes be good to make? I can
attempt something.

> commit ce1cf26540b96fc52aec6f6f8e365960ca79a0ad
> Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date:   Sun Aug 13 20:36:02 2023 +0000
>
>     rcutorture: Copy out ftrace into its own console file
>
>     When debugging it can be difficult to quickly find the ftrace dump
>     withiin the console log, which in turn makes it difficult to process =
it

Nit: within.

>     independent of the result of the console output.  This commit therefo=
re
>     copies the contents of the buffers into its own file to make it easie=
r
>     to locate and process the ftrace dump. The original ftrace dump is st=
ill
>     available in the console log in cases where it is more convenient to
>     process it there, for example, when you have a script that processes
>     console output as well as ftrace-dump data.
>
>     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/=
testing/selftests/rcutorture/bin/functions.sh
> old mode 100644
> new mode 100755
> index b8e2ea23cb3f..40bcddf5f197
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -331,3 +331,27 @@ specify_qemu_net () {
>                 echo $1 -net none
>         fi
>  }
> +
> +# Extract the ftrace output from the console log output
> +# The ftrace output looks in the logs looks like:

My bad:  s/output looks/output/

Thanks,

 - Joel


> +# Dumping ftrace buffer:
> +# ---------------------------------
> +# [...]
> +# ---------------------------------
> +extract_ftrace_from_console() {
> +       awk '
> +       /Dumping ftrace buffer:/ {
> +               capture =3D 1
> +               next
> +       }
> +       /---------------------------------/ {
> +               if (capture =3D=3D 1) {
> +                       capture =3D 2
> +                       next
> +               } else if (capture =3D=3D 2) {
> +                       capture =3D 0
> +               }
> +       }
> +       capture =3D=3D 2
> +       ' "$1";
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
