Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1E809A15
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573030AbjLHDNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjLHDNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:13:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827E10DD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:13:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54f4a933ddcso3822a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 19:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702005195; x=1702609995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNS+ovI/q3JlBtEM2uaw1KWaKlXeGtEnkG9NS8Et7tA=;
        b=gbXD9atyXPm1oP5XU2qeen+pJTOmZ3e7iuZfb3wcN5G4mm0Aag6J77DYgA2Cm/RYz3
         VnyWsQLRRsJ25zx4+j944KrbGoQTYS5wcATkdB7i2YPSLtNz7949WzZjb+UOH/bxuCyk
         49Xy4ScmeS2wecVCQ5dxBNxglrovY7RKTfjWETzfq+E82GvCtt9bEWUb/GX9aXiVtLy1
         vQO+AY6le5lApFq2Mu/fiVNEVpP6HXiQh35qVKDno5R5dN7LZRaQx3wz4xB/4OFFrs7S
         1oHgf/M3gVEWrGhTyiqEcL0WBMU2iWngKfsFAEHQUVRdL4lWVZJ1EjrxfbTqgyo2JFR2
         b9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005195; x=1702609995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNS+ovI/q3JlBtEM2uaw1KWaKlXeGtEnkG9NS8Et7tA=;
        b=Bov/yCRMYMf37FEVUm/nKihUpmvbK1YprGrFIj/BcwmHCs69JtrVx/fw5bVUoGziUV
         nVLPp0dmA7IgQzwAdBnrmqhFQ30ccZqlUo1dGaM4A4h+mcpKMMJCxkhXVKNNaDffhXM3
         ub3EPktPo3ALhfcZT5BhNaykYzpgJZlntoV2awA6wvJuP6/JEitHp7ApeAOwvwOZonfx
         rmJJgANqW5ec2dBNdTq+1ORLGJIbJvthvPajQdTHvWoM8id6FNqvxpqt+O86hOvoeV9c
         VMPuMKO2yN4K/Wvlkd1+J9XKEDMW+WHqc+b0URo3IP6SQPUOQX6AX8Q+qwiG9nhrHM78
         nHjw==
X-Gm-Message-State: AOJu0YyOiQG+JTc9XiP969TA4QEMJp2v5bDygU2H+rnKh44LEtHsUoTU
        Afi9cFpii9mAEBpRBbRpBKoVmt4DY82zMwga4QTfiA==
X-Google-Smtp-Source: AGHT+IF6lnS9jdG7Mel03q85kJn6B8enFm7q6yqnXLrTB095MG3Pt7OgvO20urLr5o46zc0NbKZAl1GRCClQ4zRkKn4=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr20514edj.0.1702005194949; Thu, 07 Dec
 2023 19:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20231207213410.417564-1-rmoar@google.com> <20231207213410.417564-2-rmoar@google.com>
In-Reply-To: <20231207213410.417564-2-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 8 Dec 2023 11:13:03 +0800
Message-ID: <CABVgOSkqH0Gsw-w5Dkm2dRfFTOd5_zhBawn0Lwgf+rkckRWpfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: tool: add test for parsing attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 05:34, Rae Moar <rmoar@google.com> wrote:
>
> Add test for parsing attributes to kunit_tool_test.py. Test checks
> attributes are parsed and saved in the test logs.
>
> This test also checks that the attributes have not interfered with the
> parsing of other test information, specifically the suite header as
> the test plan was being incorrectely parsed.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks -- it's good to have this tested. I'm looking forward to our
actually parsing attributes out and using them for things in the
future, too.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_tool_test.py           | 16 ++++++++++++++++
>  .../kunit/test_data/test_parse_attributes.log    |  9 +++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 tools/testing/kunit/test_data/test_parse_attributes.log
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index b28c1510be2e..2beb7327e53f 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -331,6 +331,22 @@ class KUnitParserTest(unittest.TestCase):
>                         kunit_parser.parse_run_tests(file.readlines())
>                 self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
>
> +       def test_parse_attributes(self):
> +               ktap_log = test_data_path('test_parse_attributes.log')
> +               with open(ktap_log) as file:
> +                       result = kunit_parser.parse_run_tests(file.readlines())
> +
> +               # Test should pass with no errors
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=0))
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +
> +               # Ensure suite header is parsed correctly
> +               self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
> +
> +               # Ensure attributes in correct test log
> +               self.assertContains('# module: example', result.subtests[0].log)
> +               self.assertContains('# test.speed: slow', result.subtests[0].subtests[0].log)
> +
>         def test_show_test_output_on_failure(self):
>                 output = """
>                 KTAP version 1
> diff --git a/tools/testing/kunit/test_data/test_parse_attributes.log b/tools/testing/kunit/test_data/test_parse_attributes.log
> new file mode 100644
> index 000000000000..1a13c371fe9d
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_parse_attributes.log
> @@ -0,0 +1,9 @@
> +KTAP version 1
> +1..1
> +  KTAP version 1
> +  # Subtest: suite
> +  # module: example
> +  1..1
> +  # test.speed: slow
> +  ok 1 test
> +ok 1 suite
> \ No newline at end of file

Why doesn't this have a newline at the end of the file?

I'm actually okay with it here (it's good to test the case where there
isn't one _somewhere_), but in general, I think we'd want to prefer
KTAP documents end with the trailing newline, like most text file.
