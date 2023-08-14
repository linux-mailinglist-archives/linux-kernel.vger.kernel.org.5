Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A12F77AF88
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjHNC3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjHNC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:29:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55AC18F;
        Sun, 13 Aug 2023 19:29:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so4760771a12.0;
        Sun, 13 Aug 2023 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691980143; x=1692584943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvpYYiAYu1ac8b8p2kq6uk7MdUFJjCnkQ744MsBnp7Y=;
        b=f2HyYn6/frOnX4Q8/+GhKmfLA4Ha2vgMQJ4j6wDTj4o2dHAOxWt08DLIdh/RJjW3gz
         xN6zjeR2XOvf0tdfXSAVxQ0pXwEC+1jQ/x+WW5LemZddrdBHz6Y5unLGAFH+TmP3dbQe
         6kQQBWGCi4xQp5FrdeMboe+tkOt7eyaoYXZTTswQrAidDtU4o0lAVHBmg11T3h+xFhKC
         10Je9oLVKFBAdqASntzqK3eW3sSea6XtWJvMh6O59kJfMBBmP8zpgsDPBYgEq2HMfjJQ
         zE/Ma9mIKePqd2AB095cyvBD0KWCMaqS1QvawFHah/8RIgRwCWCHHIdt4xYyARbM90aY
         Ez4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691980143; x=1692584943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvpYYiAYu1ac8b8p2kq6uk7MdUFJjCnkQ744MsBnp7Y=;
        b=lLv82SrAT0w40xib3KXuTIDZ05D78jPc8Oa1myjrIb4w21DVxpOx7lyVyyAhWlEV+k
         TI8ypjEfjeSpgo1QeSWZpjeMvq5NV1D7Q0sC1Wmn98CyEeRNfFM8RfgKbN0j5kKx3/mK
         i4zoTRUywyd6g6rCJWtcdldZXL/5DKlCM2tdbE+pnS8iCduTI9BP0H4QpkLg2KMnqOK3
         kPJIQTP7ayeGjpurjDzO1rkSSEnYunzfU2UwHHY0Wbzjax4azL8nCOAue9gcAGQbdhK8
         V/aevVmbdIsj6g+OXrvdyzZ35ec0UiImtoXAMvGNl6EA+Dwws9/+i3RvOkXtRa7CWKN6
         bu7w==
X-Gm-Message-State: AOJu0Yy+XBuTU82y6u/6l3TAfFB0zXFkEDD8ED2SWX6YqRC16Ani7MX6
        12nDLxZ2PQE7YSRMqWpKvqTDej/xQYofpek6h503SVVvZxOWtg==
X-Google-Smtp-Source: AGHT+IHUsz7OSC6723JEBZPfbvLjnYW+ZxHERoC0DSuaibary1V55BQ41fqJ5z4xjmZncaGm0oaM5x0cAD239BXKDIU=
X-Received: by 2002:a05:6402:799:b0:523:2847:fb5a with SMTP id
 d25-20020a056402079900b005232847fb5amr5070264edy.40.1691980142883; Sun, 13
 Aug 2023 19:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230803234122.19b3d3a4@rorschach.local.home> <20230810055023.67529-2-zegao@tencent.com>
 <20230811132811.28b9b766@gandalf.local.home>
In-Reply-To: <20230811132811.28b9b766@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Mon, 14 Aug 2023 10:28:51 +0800
Message-ID: <CAD8CoPDqZrd2HOUCVkrOq9JgJEQwQnqBn9zD1A3M4aKLZ4mLvg@mail.gmail.com>
Subject: Re: [PATCH] perf sched: parse task state from tracepoint print format
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, zegao@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 1:28=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 10 Aug 2023 01:50:24 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Hi Steven,
> >
> > I managed to build task state char map dynamically by parsing
> > the tracepoint print format from data recorded by perf. And
> > likewise for libtraceevent.
> >
> > FYI, I tried TEP_PRINT_INFO but no shot. It turns out TEP_PRINT_INFO
> > stills relies on libtraceevent (i.e., sched_switch_handler() in
> > plugin_sched_switch.c) and we need to parse the print format on our own=
.
>
> There is a way to unload plugins:
>
>         tep_unload_plugins(t->plugin_list, tep);
>
> Hmm, I should add:
>
>         tep_unload_plugin(tep, t->plugin_list, "plugin-name");
>
> To unload a single plugin.
>
> I it can also just override what the plugin does by calling:
>
> static int sched_switch_handler(struct trace_seq *s,
>                                 struct tep_record *record,
>                                 struct tep_event *event, void *context)
> {
>         // do whatever you want.
> }
>
>         tep_register_event_handler(tep, -1, "sched", "sched_switch",
>                                    sched_switch_handler, NULL);
>
Yes,  I chose to fix libtraceevent in a similar way, to not break
users of this plugin,
like perf script, I decided to build state char mapping dynamically
for both instead
of overriding sched_switch_handler in libtraceevent. Here is the patch:

From e4fae23d9538e60e75a9776fa7938102e7c26bbb Mon Sep 17 00:00:00 2001
From: Ze Gao <zegao@tencent.com>
Date: Wed, 2 Aug 2023 07:20:46 -0400
Subject: [PATCH] libtraceevent: parse task state from tracepoint print form=
at

As of this writing, we use prev_state to report task state, which
relies on both the task state macros and TASK_STATE_TO_CHAR_STR
copied from the kernel to interpret its actual meaning. In this way,
libtraceevent gets broken literally each time TASK_STATE_TO_CHAR_STR
changes as the kernel evolves. Counting on hardcoded
TASK_STATE_TO_CHAR_STR gurantees no backward compatibilty.

To fix this, we build the state char map from the print format
parsed from date recorded on the fly and removes dependencies on
these internal kernel definitions.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 plugins/plugin_sched_switch.c | 103 ++++++++++++++++++++++++++++------
 1 file changed, 87 insertions(+), 16 deletions(-)

diff --git a/plugins/plugin_sched_switch.c b/plugins/plugin_sched_switch.c
index 8752cae..a0df138 100644
--- a/plugins/plugin_sched_switch.c
+++ b/plugins/plugin_sched_switch.c
@@ -6,28 +6,25 @@
 #include <stdlib.h>
 #include <string.h>

+#include "event-utils.h"
 #include "event-parse.h"
 #include "trace-seq.h"

-static void write_state(struct trace_seq *s, int val)
-{
-       const char states[] =3D "SDTtZXxW";
-       int found =3D 0;
-       int i;
+#define TASK_STATE_MAX 16

-       for (i =3D 0; i < (sizeof(states) - 1); i++) {
-               if (!(val & (1 << i)))
-                       continue;
+static char state_to_char[TASK_STATE_MAX];
+static unsigned int num_sleeping_states =3D 0;

-               if (found)
-                       trace_seq_putc(s, '|');

-               found =3D 1;
-               trace_seq_putc(s, states[i]);
-       }
+static void write_state(struct trace_seq *s, int val)
+{
+       unsigned int bit =3D val ? ffs(val) : 0;
+       char state;

-       if (!found)
-               trace_seq_putc(s, 'R');
+       state =3D (!bit || bit > num_sleeping_states) ? 'R' : state_to_char=
[bit];
+       trace_seq_putc(s, state);
+       if(bit > num_sleeping_states)
+               trace_seq_putc(s, '+');
 }

 static void write_and_save_comm(struct tep_format_field *field,
@@ -79,6 +76,76 @@ static int sched_wakeup_handler(struct trace_seq *s,
        return 0;
 }

+static const struct tep_print_arg* task_state_print_flag(const struct
tep_event *event) {
+
+       struct tep_print_arg* args;
+
+       if (!event)
+               goto out;
+
+       args =3D event->print_fmt.args;
+       while(args)
+       {
+               if (args->type =3D=3D TEP_PRINT_FLAGS)
+                       return args;
+               if (args->type =3D=3D TEP_PRINT_OP) {
+                       args =3D args->op.right;
+                       args =3D args->op.left;
+                       continue;
+               }
+               args =3D args->next;
+       }
+out:
+       return NULL;
+}
+
+static int parse_task_state_arr(const char *value, const char *str)
+{
+       long val;
+       unsigned int bit;
+
+       if (!value || !str)
+               return -1;
+
+       val =3D strtol(value, NULL, 0);
+       bit =3D val ? ffs(val) : 0;
+       state_to_char[bit] =3D str[0];
+       num_sleeping_states++;
+       if (num_sleeping_states > TASK_STATE_MAX - 1) {
+               tep_warning("too many states parsed, possibly bad format\n"=
);
+               return -1;
+       }
+       return 0;
+}
+
+static void parse_print_flag(const struct tep_print_flag_sym* field,
+                            int (*parser)(const char *value, const char *s=
tr))
+{
+       int err;
+
+       if (!field || !parser)
+               return;
+       err =3D parser(field->value, field->str);
+       if (err){
+               tep_warning("parsing print flag failed, possibly bad format=
\n");
+               return;
+       }
+       if (field->next)
+               parse_print_flag(field->next, parser);
+
+}
+
+static void build_task_state_arr(const struct tep_event *event)
+{
+       const struct tep_print_arg* args;
+
+       args =3D task_state_print_flag(event);
+       if (!args)
+               tep_warning("print flag not found, possibly bad format\n");
+       else
+               parse_print_flag(args->flags.flags, parse_task_state_arr);
+}
+
 static int sched_switch_handler(struct trace_seq *s,
                                struct tep_record *record,
                                struct tep_event *event, void *context)
@@ -99,8 +166,12 @@ static int sched_switch_handler(struct trace_seq *s,
        if (tep_get_field_val(s, event, "prev_prio", record, &val, 1) =3D=
=3D 0)
                trace_seq_printf(s, "[%d] ", (int) val);

-       if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) =3D=
=3D 0)
+
+       if (tep_get_field_val(s,  event, "prev_state", record, &val, 1) =3D=
=3D 0) {
+               if (!num_sleeping_states)
+                       build_task_state_arr(event);
                write_state(s, val);
+       }

        trace_seq_puts(s, " =3D=3D> ");

--
2.41.0



> > Anyway, it works now and I've tested on some perf.data in old formats
> > but not cover all the kernel releases.
> >
> > Thoughts?
>
> I don't maintain the perf code. You'll have to talk with the perf
> maintainers.

Roger that! Thank you very much!

Regards,
Ze

> -- Steve
