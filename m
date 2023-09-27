Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C707B0EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjI0W2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjI0W2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:28:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB854AF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:28:51 -0700 (PDT)
Received: from [192.168.231.116] (unknown [177.25.212.118])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCB5266072C1;
        Wed, 27 Sep 2023 23:28:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695853730;
        bh=mixw0IUuMi5bpKZUwSfeBz7ngQLEjUGeaylYpZ19ezI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nRBbn2juAT7mMV4Pt6qbzIOzWPpCv0Du6Dqlwr63v3wEXrIkClBYkg27rM681N7o3
         +DZmYDbLOFAUiKurum7bagKlu56yFY07eM/zdRcR76IgYdxeVHy/oAmw6iK+vc0Mmh
         Mc2OM55mZ2mja8lSFhiqEJQldO22+P4gGKqewWs5F+RCiV8XBhKJ11K5BS1qT/7E2W
         aSM3gzozApf8S9KQUpv86bleLXQxeCxY3/ORwFSKYrbPMi4aOs7HeCN+x/2Q7D48Gn
         sr/kECPTFwZ1zdeo52FgbdOPG0v5U8gDCxXSmsKTnAeXsuNVmGmUfV+MbyiTmspYbe
         1qfIccvw0++PQ==
Message-ID: <785cbfee-f4d3-3d53-a3e6-2f9af8fa05fb@collabora.com>
Date:   Wed, 27 Sep 2023 19:28:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH] drm/ci: add helper script update-xfails.py
Content-Language: en-US
To:     Sergi Blanch Torne <sergi.blanch.torne@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, daniel@fooishbar.org,
        vignesh.raman@collabora.com, jani.nikula@linux.intel.com,
        mripard@kernel.org, michel.daenzer@mailbox.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        david.heidelberg@collabora.com, guilherme.gallo@collabora.com
References: <20230925195556.106090-1-helen.koike@collabora.com>
 <8f946d0a5632d580b593cf731091126d59feb77f.camel@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <8f946d0a5632d580b593cf731091126d59feb77f.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergi,

Thanks for your comments.

On 27/09/2023 05:58, Sergi Blanch Torne wrote:
> Hi Helen,
> 
> On Mon, 2023-09-25 at 16:55 -0300, Helen Koike wrote:
>> Hello,
> 
>> This script is being very handy for me, so I suppose it could be
>> handy
>> to others, since I'm publishing it in the xfails folder.
> 
>> Let me know your thoughts.
> 
> I have two suggestions and one comment. Before that, I would like to
> highlight the importance of tools like that to help with repetitive
> tedious work, it is great to have this script.
> 
>> +def get_xfails_file_path(canonical_name, suffix):
>> +    name = canonical_name.replace(":", "-")
>> +    script_dir = os.path.dirname(os.path.abspath(__file__))
>> +    return os.path.join(script_dir, f"{name}-{suffix}.txt")
> 
> I appreciate the correspondence between job name and expectation file
> names.
> 
>> +def get_unit_test_name_and_results(unit_test):
>> +    if "Artifact results/failures.csv not found" in unit_test:
>> +        return None, None
>> +    unit_test_name, unit_test_result = unit_test.strip().split(",")
>> +    return unit_test_name, unit_test_result
> 
> Suggestion: it is not managing empty lines or comments. By now, there
> aren't, but they could be found.

Indeed.

> 
>> +def main(namespace, project, pipeline_id):
>> +    xfails = (
>> +        Collate(namespace=namespace, project=project)
>> +        .from_pipeline(pipeline_id)
>> +        .get_artifact("results/failures.csv")
>> +    )
>> +
>> +    split_unit_test_from_collate(xfails)
>> +
>> +    for job_name in xfails.keys():
>> +        canonical_name = get_canonical_name(job_name)
>> +        fails_txt_path = get_xfails_file_path(canonical_name,
>> "fails")
>> +        flakes_txt_path = get_xfails_file_path(canonical_name,
>> "flakes")
>> +
>> +        fails_txt = read_file(fails_txt_path)
>> +        flakes_txt = read_file(flakes_txt_path)
>> +
>> +        for job_id in xfails[job_name].keys():
>> +            for unit_test in xfails[job_name][job_id]:
>> +                unit_test_name, unit_test_result =
>> get_unit_test_name_and_results(unit_test)
>> +
>> +                if not unit_test_name:
>> +                    continue
>> +
>> +                if is_test_present_on_file(flakes_txt,
>> unit_test_name):
>> +                    remove_unit_test_if_present(flakes_txt,
>> unit_test_name, flakes_txt_path)
>> +                    print("WARNING: unit test is on flakes list but
>> a job failed due to it, "
>> +                          "is your tree up to date?",
>> +                          unit_test_name, "DROPPED FROM",
>> os.path.basename(flakes_txt_path))
>> +
>> +                if unit_test_result == "UnexpectedPass":
>> +                    remove_unit_test_if_present(fails_txt,
>> unit_test_name, fails_txt_path)
>> +                    # flake result
>> +                    if not
>> is_unit_test_present_in_other_jobs(unit_test, xfails[job_name]):
>> +                        add_unit_test_if_not_present(flakes_txt,
>> unit_test_name, flakes_txt_path)
>> +                    continue
> 
> Suggestion: Sometimes tests fails with different status ("Fail" to
> "Crash" for example) and the expectations should be updated with the
> newer status.

The status is only present in the fails and not in the flakes list, so I 
update it with add_unit_test_or_update_result_to_fails_if_present() 
function below, make sense?

Regards,
Helen

> 
>> +
>> +                # flake result
>> +                if not is_unit_test_present_in_other_jobs(unit_test,
>> xfails[job_name]):
>> +                    add_unit_test_if_not_present(flakes_txt,
>> unit_test_name, flakes_txt_path)
>> +                    continue
>> +
>> +                # consistent result
>> +
>> add_unit_test_or_update_result_to_fails_if_present(fails_txt,
>> unit_test,
>> +
>> fails_txt_path)
>> +
>> +        save_file(fails_txt, fails_txt_path)
>> +        save_file(flakes_txt, flakes_txt_path)
> 
> Regards,
> 
