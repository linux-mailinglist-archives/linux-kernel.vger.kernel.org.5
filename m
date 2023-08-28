Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DEF78B389
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjH1OsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjH1Orp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:47:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C6C136
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:47:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5657add1073so2128806a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693234053; x=1693838853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExceV+hrrvGrpXdUMoyT/5SYkxh4kUw1IYyrUMACmZs=;
        b=hRMqq5hVKK0gMe+Ktzn8O+AePjKMYaGeOfOjtFOleMfY2bpVFGAyr5Tb51GkJEquzp
         6xIKksDL1WfcMyidWqB9xB460JM/z6cj8EHA0z8PK1MrhqotyiHLwDwjtlH9NwtclcgC
         c3R2F/bja1Kme2reS1Ljdi9mRmQogCbNMNbM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234053; x=1693838853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExceV+hrrvGrpXdUMoyT/5SYkxh4kUw1IYyrUMACmZs=;
        b=Hj4xj9sYYO8io/KTGAHvZ6Q/DzmqJzh8UbBzM6nAQwEgPXvOwhY2qIDJ4CLFalSSzx
         nmArBsV41N2KyRKKWHVY8XCVznTYMSI6e8BWKzhOcDL65CnaI5aDTqVpPQT2JULXpO+w
         yvTAc61Ldw8XQHNbKk7QMnktIW8fC/CSweSjE4RlbE21IOeXgWqGUCJ7GYLpk98C9D/l
         wVow2ToXDzn7IxFByvp0s7cr4qJ5W26mTUWmceQNiBVXc5doUg6nkwcc6i1n5I7t1Ul9
         CR4eHq5ygd4XQq8QzENXefR7mP1Y0rck98UMVPTmHUmOf9uF5GiBJgBAc4rd8eWfeGWl
         RpsQ==
X-Gm-Message-State: AOJu0YxkXgVx65/FbL/LvJelt2yhtIqmE8/frlNC2Ggg7IMlAXcFiuCH
        ohfDTwOEovq6MEvWrzWTBEIG2HPnKBI/xgRLHEYD6A==
X-Google-Smtp-Source: AGHT+IGu90ReA3cm4dDkeELUS1d/I9GphXu+VHcIkMBRJeYE7IjncmkQmrYZO11+F3sPny3dE3iQMhcxXmFk1/KnXTw=
X-Received: by 2002:a17:90a:cb12:b0:26f:6f2a:a11 with SMTP id
 z18-20020a17090acb1200b0026f6f2a0a11mr32136188pjt.12.1693234052762; Mon, 28
 Aug 2023 07:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230704153630.1591122-1-revest@chromium.org> <20230704153630.1591122-6-revest@chromium.org>
 <202308251538.F716651@keescook>
In-Reply-To: <202308251538.F716651@keescook>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 28 Aug 2023 16:47:21 +0200
Message-ID: <CABRcYmLYHf28xNTCs_W2rMYH-78fiyOnhXWsgABUwjHOtvC7qw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] kselftest: vm: Add tests for no-inherit memory-deny-write-execute
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 12:45=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Jul 04, 2023 at 05:36:29PM +0200, Florent Revest wrote:
> > Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> > PR_SET_MDWE prctl.
> >
> > Check that:
> > - it can't be set without PR_SET_MDWE
> > - MDWE flags can't be unset
> > - when set, PR_SET_MDWE doesn't propagate to children
>
> I love more self tests! :)

*Insert here a ridiculously long series of party and dancing emojis* ... :)

> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mdwe_test.c | 98 ++++++++++++++++++++++++--
> >  1 file changed, 92 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/sel=
ftests/mm/mdwe_test.c
> > index 91aa9c3099e7..7bfc98bf9baa 100644
> > --- a/tools/testing/selftests/mm/mdwe_test.c
> > +++ b/tools/testing/selftests/mm/mdwe_test.c
> > @@ -22,6 +22,8 @@
> >
> >  TEST(prctl_flags)
> >  {
> > +     EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
> > +
>
> An existing issue, but I think the errno should be checked for each
> of these...

Makes sense! I'll add a bunch of
    EXPECT_EQ(errno, EINVAL);

To every existing line here as part of a previous patch, and modify
this patch to cover errnos in the new test cases too.

> >       EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
> >       EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
> >       EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 7L, 0L), 0);
> > @@ -33,6 +35,69 @@ TEST(prctl_flags)
> >       EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 0L, 7L), 0);
> >  }
> >
> > +FIXTURE(consecutive_prctl_flags) {};
> > +FIXTURE_SETUP(consecutive_prctl_flags) {}
> > +FIXTURE_TEARDOWN(consecutive_prctl_flags) {}
> > +
> > +FIXTURE_VARIANT(consecutive_prctl_flags)
> > +{
> > +     unsigned long first_flags;
> > +     unsigned long second_flags;
> > +     bool should_work;
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, same)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .should_work =3D true,
> > +};
>
> I think two more variants should be added to get all the combinations:
>
> FIXTURE_VARIANT_ADD(consecutive_prctl_no_flags, same)
> {
>         .first_flags =3D 0,
>         .second_flags =3D 0,
>         .should_work =3D true,
> };
>
> FIXTURE_VARIANT_ADD(consecutive_prctl_both_flags, same)
> {
>         .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
>         .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
>         .should_work =3D true,
> };

Agreed! :)

> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .second_flags =3D 0,
> > +     .should_work =3D false,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe_no_inhe=
rit)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> > +     .second_flags =3D 0,
> > +     .should_work =3D false,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_no_inherit)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> > +     .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .should_work =3D false,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_enable_no_inherit)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> > +     .should_work =3D false,
> > +};
> > +
> > +TEST_F(consecutive_prctl_flags, two_prctls)
> > +{
> > +     int ret;
> > +
> > +     EXPECT_EQ(prctl(PR_SET_MDWE, variant->first_flags, 0L, 0L, 0L), 0=
);
> > +
> > +     ret =3D prctl(PR_SET_MDWE, variant->second_flags, 0L, 0L, 0L);
> > +     if (variant->should_work) {
> > +             EXPECT_EQ(ret, 0);
> > +
> > +             ret =3D prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
> > +             ASSERT_EQ(ret, variant->second_flags);
> > +     } else {
> > +             EXPECT_NE(ret, 0);
>
> Please test the expected errno value here.

Alright!

> > +     }
> > +}
> > +
> >  FIXTURE(mdwe)
> >  {
> >       void *p;
> > @@ -45,28 +110,45 @@ FIXTURE_VARIANT(mdwe)
> >  {
> >       bool enabled;
> >       bool forked;
> > +     bool inherit;
> >  };
> >
> >  FIXTURE_VARIANT_ADD(mdwe, stock)
> >  {
> >       .enabled =3D false,
> >       .forked =3D false,
> > +     .inherit =3D false,
> >  };
> >
> >  FIXTURE_VARIANT_ADD(mdwe, enabled)
> >  {
> >       .enabled =3D true,
> >       .forked =3D false,
> > +     .inherit =3D true,
> >  };
> >
> > -FIXTURE_VARIANT_ADD(mdwe, forked)
> > +FIXTURE_VARIANT_ADD(mdwe, inherited)
> >  {
> >       .enabled =3D true,
> >       .forked =3D true,
> > +     .inherit =3D true,
> >  };
> >
> > +FIXTURE_VARIANT_ADD(mdwe, not_inherited)
> > +{
> > +     .enabled =3D true,
> > +     .forked =3D true,
> > +     .inherit =3D false,
> > +};
> > +
> > +static bool executable_map_should_fail(const FIXTURE_VARIANT(mdwe) *va=
riant)
> > +{
> > +     return variant->enabled && (!variant->forked || variant->inherit)=
;
> > +}
> > +
> >  FIXTURE_SETUP(mdwe)
> >  {
> > +     unsigned long mdwe_flags;
> >       int ret, status;
> >
> >       self->p =3D NULL;
> > @@ -76,13 +158,17 @@ FIXTURE_SETUP(mdwe)
> >       if (!variant->enabled)
> >               return;
> >
> > -     ret =3D prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0L, 0L, 0L);
> > +     mdwe_flags =3D PR_MDWE_REFUSE_EXEC_GAIN;
> > +     if (!variant->inherit)
> > +             mdwe_flags |=3D PR_MDWE_NO_INHERIT;
> > +
> > +     ret =3D prctl(PR_SET_MDWE, mdwe_flags, 0L, 0L, 0L);
> >       ASSERT_EQ(ret, 0) {
> >               TH_LOG("PR_SET_MDWE failed or unsupported");
> >       }
> >
> >       ret =3D prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
> > -     ASSERT_EQ(ret, 1);
> > +     ASSERT_EQ(ret, mdwe_flags);
> >
> >       if (variant->forked) {
> >               self->pid =3D fork();
> > @@ -113,7 +199,7 @@ TEST_F(mdwe, mmap_READ_EXEC)
> >  TEST_F(mdwe, mmap_WRITE_EXEC)
> >  {
> >       self->p =3D mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->=
flags, 0, 0);
> > -     if (variant->enabled) {
> > +     if (executable_map_should_fail(variant)) {
> >               EXPECT_EQ(self->p, MAP_FAILED);
> >       } else {
> >               EXPECT_NE(self->p, MAP_FAILED);
> > @@ -139,7 +225,7 @@ TEST_F(mdwe, mprotect_add_EXEC)
> >       ASSERT_NE(self->p, MAP_FAILED);
> >
> >       ret =3D mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
> > -     if (variant->enabled) {
> > +     if (executable_map_should_fail(variant)) {
> >               EXPECT_LT(ret, 0);
> >       } else {
> >               EXPECT_EQ(ret, 0);
> > @@ -154,7 +240,7 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
> >       ASSERT_NE(self->p, MAP_FAILED);
> >
> >       ret =3D mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
> > -     if (variant->enabled) {
> > +     if (executable_map_should_fail(variant)) {
> >               EXPECT_LT(ret, 0);
> >       } else {
> >               EXPECT_EQ(ret, 0);
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
>
> Otherwise looks good to me!

*more happy emojis*




On Sat, Aug 26, 2023 at 12:45=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Jul 04, 2023 at 05:36:29PM +0200, Florent Revest wrote:
> > Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> > PR_SET_MDWE prctl.
> >
> > Check that:
> > - it can't be set without PR_SET_MDWE
> > - MDWE flags can't be unset
> > - when set, PR_SET_MDWE doesn't propagate to children
>
> I love more self tests! :)
>
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mdwe_test.c | 98 ++++++++++++++++++++++++--
> >  1 file changed, 92 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/sel=
ftests/mm/mdwe_test.c
> > index 91aa9c3099e7..7bfc98bf9baa 100644
> > --- a/tools/testing/selftests/mm/mdwe_test.c
> > +++ b/tools/testing/selftests/mm/mdwe_test.c
> > @@ -22,6 +22,8 @@
> >
> >  TEST(prctl_flags)
> >  {
> > +     EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
> > +
>
> An existing issue, but I think the errno should be checked for each
> of these...
>
> >       EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
> >       EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
> >       EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 7L, 0L), 0);
> > @@ -33,6 +35,69 @@ TEST(prctl_flags)
> >       EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 0L, 7L), 0);
> >  }
> >
> > +FIXTURE(consecutive_prctl_flags) {};
> > +FIXTURE_SETUP(consecutive_prctl_flags) {}
> > +FIXTURE_TEARDOWN(consecutive_prctl_flags) {}
> > +
> > +FIXTURE_VARIANT(consecutive_prctl_flags)
> > +{
> > +     unsigned long first_flags;
> > +     unsigned long second_flags;
> > +     bool should_work;
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, same)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .should_work =3D true,
> > +};
>
> I think two more variants should be added to get all the combinations:
>
> FIXTURE_VARIANT_ADD(consecutive_prctl_no_flags, same)
> {
>         .first_flags =3D 0,
>         .second_flags =3D 0,
>         .should_work =3D true,
> };
>
> FIXTURE_VARIANT_ADD(consecutive_prctl_both_flags, same)
> {
>         .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
>         .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
>         .should_work =3D true,
> };
>
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .second_flags =3D 0,
> > +     .should_work =3D false,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe_no_inhe=
rit)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> > +     .second_flags =3D 0,
> > +     .should_work =3D false,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_no_inherit)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> > +     .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .should_work =3D false,
> > +};
> > +
> > +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_enable_no_inherit)
> > +{
> > +     .first_flags =3D PR_MDWE_REFUSE_EXEC_GAIN,
> > +     .second_flags =3D PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> > +     .should_work =3D false,
> > +};
> > +
> > +TEST_F(consecutive_prctl_flags, two_prctls)
> > +{
> > +     int ret;
> > +
> > +     EXPECT_EQ(prctl(PR_SET_MDWE, variant->first_flags, 0L, 0L, 0L), 0=
);
> > +
> > +     ret =3D prctl(PR_SET_MDWE, variant->second_flags, 0L, 0L, 0L);
> > +     if (variant->should_work) {
> > +             EXPECT_EQ(ret, 0);
> > +
> > +             ret =3D prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
> > +             ASSERT_EQ(ret, variant->second_flags);
> > +     } else {
> > +             EXPECT_NE(ret, 0);
>
> Please test the expected errno value here.
>
> > +     }
> > +}
> > +
> >  FIXTURE(mdwe)
> >  {
> >       void *p;
> > @@ -45,28 +110,45 @@ FIXTURE_VARIANT(mdwe)
> >  {
> >       bool enabled;
> >       bool forked;
> > +     bool inherit;
> >  };
> >
> >  FIXTURE_VARIANT_ADD(mdwe, stock)
> >  {
> >       .enabled =3D false,
> >       .forked =3D false,
> > +     .inherit =3D false,
> >  };
> >
> >  FIXTURE_VARIANT_ADD(mdwe, enabled)
> >  {
> >       .enabled =3D true,
> >       .forked =3D false,
> > +     .inherit =3D true,
> >  };
> >
> > -FIXTURE_VARIANT_ADD(mdwe, forked)
> > +FIXTURE_VARIANT_ADD(mdwe, inherited)
> >  {
> >       .enabled =3D true,
> >       .forked =3D true,
> > +     .inherit =3D true,
> >  };
> >
> > +FIXTURE_VARIANT_ADD(mdwe, not_inherited)
> > +{
> > +     .enabled =3D true,
> > +     .forked =3D true,
> > +     .inherit =3D false,
> > +};
> > +
> > +static bool executable_map_should_fail(const FIXTURE_VARIANT(mdwe) *va=
riant)
> > +{
> > +     return variant->enabled && (!variant->forked || variant->inherit)=
;
> > +}
> > +
> >  FIXTURE_SETUP(mdwe)
> >  {
> > +     unsigned long mdwe_flags;
> >       int ret, status;
> >
> >       self->p =3D NULL;
> > @@ -76,13 +158,17 @@ FIXTURE_SETUP(mdwe)
> >       if (!variant->enabled)
> >               return;
> >
> > -     ret =3D prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0L, 0L, 0L);
> > +     mdwe_flags =3D PR_MDWE_REFUSE_EXEC_GAIN;
> > +     if (!variant->inherit)
> > +             mdwe_flags |=3D PR_MDWE_NO_INHERIT;
> > +
> > +     ret =3D prctl(PR_SET_MDWE, mdwe_flags, 0L, 0L, 0L);
> >       ASSERT_EQ(ret, 0) {
> >               TH_LOG("PR_SET_MDWE failed or unsupported");
> >       }
> >
> >       ret =3D prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
> > -     ASSERT_EQ(ret, 1);
> > +     ASSERT_EQ(ret, mdwe_flags);
> >
> >       if (variant->forked) {
> >               self->pid =3D fork();
> > @@ -113,7 +199,7 @@ TEST_F(mdwe, mmap_READ_EXEC)
> >  TEST_F(mdwe, mmap_WRITE_EXEC)
> >  {
> >       self->p =3D mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->=
flags, 0, 0);
> > -     if (variant->enabled) {
> > +     if (executable_map_should_fail(variant)) {
> >               EXPECT_EQ(self->p, MAP_FAILED);
> >       } else {
> >               EXPECT_NE(self->p, MAP_FAILED);
> > @@ -139,7 +225,7 @@ TEST_F(mdwe, mprotect_add_EXEC)
> >       ASSERT_NE(self->p, MAP_FAILED);
> >
> >       ret =3D mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
> > -     if (variant->enabled) {
> > +     if (executable_map_should_fail(variant)) {
> >               EXPECT_LT(ret, 0);
> >       } else {
> >               EXPECT_EQ(ret, 0);
> > @@ -154,7 +240,7 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
> >       ASSERT_NE(self->p, MAP_FAILED);
> >
> >       ret =3D mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
> > -     if (variant->enabled) {
> > +     if (executable_map_should_fail(variant)) {
> >               EXPECT_LT(ret, 0);
> >       } else {
> >               EXPECT_EQ(ret, 0);
> > --
> > 2.41.0.255.g8b1d071c50-goog
> >
>
> Otherwise looks good to me!
>
> --
> Kees Cook
