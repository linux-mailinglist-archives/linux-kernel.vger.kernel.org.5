Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E430A76A018
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGaSNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjGaSM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:12:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B576CE4;
        Mon, 31 Jul 2023 11:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5216A61245;
        Mon, 31 Jul 2023 18:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07BAC433C7;
        Mon, 31 Jul 2023 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690827177;
        bh=+LoXBGC73LDdBqfU5YvRRgV4ri7WaMiK0YBWUkXbAio=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q4NJvAYguFW6J0lMNQg+HqsEbIPbceiM+6wiK84nvGYZ8gp1+7tUrgeQ/KC1XBGp5
         Xb0fILtfj+LtKm8nSAyqMHwZlUvFP5S754BUBWUY2zLPyRnSQOdpWR/NFlJ2OlQYdF
         VAwD0/YJ+ifQMMtRae26U+5Yyl/mQOmaCjpPkyKCpExmxxB59NliLOMRqahd0iChkU
         5S240BpNAoN69jym1T5P9fB0MpnHnOoMjOeth2//+u0uyTHWTeSPwq8othPVymimo+
         iiFTsoX8OqypfLJrN8xSIFkNEpQCUWtVdYd+1iMfb6P8Vtsb071qGYJy41n0EXDoAC
         2s3KOTsYpaI1w==
Received: (nullmailer pid 3476368 invoked by uid 1000);
        Mon, 31 Jul 2023 18:12:54 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     David Dai <davidai@google.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>, kernel-team@android.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        linux-pm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20230731174613.4133167-2-davidai@google.com>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-2-davidai@google.com>
Message-Id: <169082717438.3476261.13394216168233236806.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: cpufreq: add bindings for virtual
 cpufreq
Date:   Mon, 31 Jul 2023 12:12:54 -0600
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 10:46:08 -0700, David Dai wrote:
> Adding bindings to represent a virtual cpufreq device.
> 
> Virtual machines may expose MMIO regions for a virtual cpufreq device for
> guests to read frequency information or to request frequency selection. The
> virtual cpufreq device has an individual controller for each CPU.
> 
> Co-developed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: David Dai <davidai@google.com>
> ---
>  .../bindings/cpufreq/cpufreq-virtual.yaml     | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Traceback (most recent call last):
  File "/usr/local/lib/python3.10/dist-packages/jsonschema/validators.py", line 909, in resolve_from_url
    document = self.store[url]
  File "/usr/local/lib/python3.10/dist-packages/jsonschema/_utils.py", line 28, in __getitem__
    return self.store[self.normalize(uri)]
KeyError: 'http://devicetree.org/meta-schemas/core.yamll'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/lib/python3.10/dist-packages/jsonschema/validators.py", line 912, in resolve_from_url
    document = self.resolve_remote(url)
  File "/usr/local/lib/python3.10/dist-packages/jsonschema/validators.py", line 1011, in resolve_remote
    result = self.handlers[scheme](uri)
  File "/usr/local/lib/python3.10/dist-packages/dtschema/schema.py", line 91, in http_handler
    raise RefResolutionError('Error in referenced schema matching $id: ' + uri)
jsonschema.exceptions.RefResolutionError: Error in referenced schema matching $id: http://devicetree.org/meta-schemas/core.yamll

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/dt-doc-validate", line 64, in <module>
    ret |= check_doc(f)
  File "/usr/local/bin/dt-doc-validate", line 32, in check_doc
    for error in sorted(dtsch.iter_errors(), key=lambda e: e.linecol):
  File "/usr/local/lib/python3.10/dist-packages/dtschema/schema.py", line 130, in iter_errors
    meta_schema = self.resolver.resolve_from_url(self['$schema'])
  File "/usr/local/lib/python3.10/dist-packages/jsonschema/validators.py", line 914, in resolve_from_url
    raise exceptions.RefResolutionError(exc)
jsonschema.exceptions.RefResolutionError: Error in referenced schema matching $id: http://devicetree.org/meta-schemas/core.yamll
Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.example.dts:69.19-72.13: Warning (unit_address_vs_reg): /example-0/soc/cpufreq: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.example.dtb: /example-0/cpus/cpu@0: failed to match any schema with compatible: ['arm,arm-v8']
Documentation/devicetree/bindings/cpufreq/cpufreq-virtual.example.dtb: /example-0/cpus/cpu@1: failed to match any schema with compatible: ['arm,arm-v8']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230731174613.4133167-2-davidai@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

