Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A87EB0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjKNN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKNN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:28:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DCF1A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:28:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C62BC433B7;
        Tue, 14 Nov 2023 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699968523;
        bh=zHHPahlzzfqA+4hQVK0aZN6whaipcl0DfBhVI2JyFME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qzu2DzV50RFYcEsklq/9642JxfcNHIoXhpANva7Hc0NmFZPNecvBP9LnfyaEoOcEq
         4dUBLRd9K7E1Abp20iA1lWBaqfdNzMm4SUzVs4hyVLCSNzalYDc0l1UrnkF387DV1H
         cLmgjxpfy+KmK78wMj7CFHwfm9xlV88s96/5ACOYK1aFAeq2KdO4CHUUQXuETG9aay
         fjzH1y1musA8UP67dRoDUrXgxX2w8awUm9aDBXuwrwQBgnMKW0H0H246En+2NWjER7
         u0TbZWPIQ5Ds0P2upnQLEr3+NcueLHhFCo8VOnl4ntTzKnHruXS20G+1LGRxJnD99m
         qTsM22yPJ0Nlg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1efb9571b13so3431902fac.2;
        Tue, 14 Nov 2023 05:28:43 -0800 (PST)
X-Gm-Message-State: AOJu0YwEkpP0QQnZPwp+J4b2SixqaoZVLYrgPvUAOSGHWsWDGLvwzcqT
        fzMyk1n3nlbt79+azy1Rk8tlPxmoqfeOe0LPORM=
X-Google-Smtp-Source: AGHT+IEMSNRpHEEYf4GiWoRD6WWm+LRYjvFHfYHtxrouzlHLa4V4DyOVtK45+ccoPsuCJ2shRnZdhsg0+X+WacJUSa0=
X-Received: by 2002:a05:6870:ac8b:b0:1eb:e8b:73cb with SMTP id
 ns11-20020a056870ac8b00b001eb0e8b73cbmr10643415oab.58.1699968522273; Tue, 14
 Nov 2023 05:28:42 -0800 (PST)
MIME-Version: 1.0
References: <20231027193016.27516-1-quic_johmoo@quicinc.com> <20231027193016.27516-4-quic_johmoo@quicinc.com>
In-Reply-To: <20231027193016.27516-4-quic_johmoo@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Nov 2023 22:28:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvKdrv7tt154xh+DFLYs41Az_FbAnSXHF2pGRvh==6mg@mail.gmail.com>
Message-ID: <CAK7LNASvKdrv7tt154xh+DFLYs41Az_FbAnSXHF2pGRvh==6mg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] check-module-params: Introduce check-module-params.sh
To:     John Moon <quic_johmoo@quicinc.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Dodji Seketeli <dodji@redhat.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2023 at 4:31=E2=80=AFAM John Moon <quic_johmoo@quicinc.com>=
 wrote:
>
> One part of maintaining backwards compatibility with older
> userspace programs is avoiding changes to module parameters.
>
> To that end, add a script (check-module-params.sh) which
> performs a simple check of module parameter changes across
> git references.
>
> For example, if this module parameter:
>
> module_param(max_nullfunc_tries, int, 0644);
>
> ...restricted its mode parameter:
>
> module_param(max_nullfunc_tries, int, 0600);
>
> The script would flag the change:
>
> Module parameter "max_nullfunc_tries" in net/mac80211/mlme.c changed!
>   Original args: int,0644
>        New args: int,0600



I know this is just a simple diff, and we cannot expect
accuracy from this tool.



I just tried

  $ ./scripts/check-module-params.sh  -b v6.7-rc1  -p v6.6

Then, I got

  error - 21/576 files with modules parameters appear _not_ to be
backwards compatible



In my understanding, it includes many false alarms.

In most of the cases, the driver was just removed.




[pattern 1] Driver was removed

Module parameter "sal_rec_max" in arch/ia64/kernel/mca_drv.c removed!

 or

Module parameter "up_delay" in
drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c removed!



[pattern 2] cosmetic change

Module parameter "nested" in arch/x86/kvm/vmx/vmx.c changed!
  Original args: bool,S_IRUGO
       New args: bool,0444





But, it sometimes catches real ones:


Module parameter "ublks_max" in drivers/block/ublk_drv.c changed!
  Original args: int,0444
       New args: &ublk_max_ublks_ops,&ublks_max,0644

 -->  Need a close check



Module parameter "vm_debug" in drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c remo=
ved!
  Original args: amdgpu_vm_debug,int,0644

 --> 887db1e49a73 is a breakage, but it seems to be intentional
     according to the commit log








> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> ---
>  scripts/check-module-params.sh | 295 +++++++++++++++++++++++++++++++++
>  1 file changed, 295 insertions(+)
>  create mode 100755 scripts/check-module-params.sh
>
> diff --git a/scripts/check-module-params.sh b/scripts/check-module-params=
.sh
> new file mode 100755
> index 000000000000..4d2b2cd483e8
> --- /dev/null
> +++ b/scripts/check-module-params.sh
> @@ -0,0 +1,295 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Script to check commits for UAPI backwards compatibility
> +
> +set -o errexit
> +set -o pipefail
> +
> +print_usage() {
> +       name=3D$(basename "$0")
> +       cat << EOF
> +$name - check for module parameters stability across git commits.
> +
> +By default, the script will check to make sure the latest commit (or cur=
rent
> +dirty changes) did not introduce changes when compared to HEAD^1. You ca=
n
> +check against additional commit ranges with the -b and -p options.
> +
> +Usage: $name [-b BASE_REF] [-p PAST_REF] [-j N] [-l ERROR_LOG] [-q] [-v]
> +
> +Options:
> +    -b BASE_REF    Base git reference to use for comparison. If unspecif=
ied or empty,
> +                   will use any dirty changes in tree to UAPI files. If =
there are no
> +                   dirty changes, HEAD will be used.
> +    -p PAST_REF    Compare BASE_REF to PAST_REF (e.g. -p v6.1). If unspe=
cified or empty,
> +                   will use BASE_REF^1. Must be an ancestor of BASE_REF.=
 Only headers
> +                   that exist on PAST_REF will be checked for compatibil=
ity.
> +    -j JOBS        Number of checks to run in parallel (default: number =
of CPU cores).
> +    -l ERROR_LOG   Write error log to file (default: no error log is gen=
erated).
> +    -q             Quiet operation (suppress stdout, still print stderr)=
.
> +    -v             Verbose operation (print more information about each =
header being checked).
> +
> +Exit codes:
> +    $SUCCESS) Success
> +    $FAILURE) Module param differences detected
> +EOF
> +}
> +
> +readonly SUCCESS=3D0
> +readonly FAILURE=3D1
> +
> +# Print to stderr
> +eprintf() {
> +       # shellcheck disable=3DSC2059
> +       printf "$@" >&2
> +}
> +
> +# Check if git tree is dirty
> +tree_is_dirty() {
> +       ! git diff --quiet
> +}
> +
> +file_module_params_unmodified() {
> +       local file=3D"$1"
> +       local base_ref=3D"$2"
> +       local past_ref=3D"$3"
> +       local base_params_file=3D"${TMP_DIR}/${file}.base"
> +       local past_params_file=3D"${TMP_DIR}/${file}.past"
> +       local error_log=3D"${TMP_DIR}/${file}.error"
> +
> +       local -r awk_cmd=3D'/^ *module_param.*\(/,/.*\);/'
> +
> +       mkdir -p "$(dirname "$error_log")"
> +       git show "${past_ref}:${file}" 2> /dev/null \
> +               | awk "$awk_cmd" > "$past_params_file" || true
> +
> +       # Ignore files that don't exist at the past ref or don't have mod=
ule params
> +       if [ ! -s "$past_params_file" ]; then
> +               return 255 # Special return code for "no-op"
> +       fi
> +
> +       if [ -z "$base_ref" ]; then
> +               awk "$awk_cmd" "${KERNEL_SRC}/${file}" \
> +                       > "$base_params_file" 2> /dev/null || true
> +       else
> +               git show "${base_ref}:${file}" 2> /dev/null \
> +                       | awk "$awk_cmd" > "$base_params_file" || true
> +       fi
> +
> +       # Process the param data to come up with an associative array of =
param names to param data
> +       # For example:
> +       #   module_param_call(foo, set_result, get_result, NULL, 0600);
> +       #
> +       # is processed into:
> +       #   pre_change_params[foo]=3D"set_result,get_result,NULL,0600"
> +       local -A pre_change_params
> +       local param_name
> +       local param_params
> +       while read -r mod_param_args; do
> +               param_name=3D"$(echo "$mod_param_args" | cut -d ',' -f 1)=
"
> +               param_params=3D"$(echo "$mod_param_args" | cut -d ',' -f =
2-)"
> +
> +               pre_change_params[$param_name]=3D$param_params
> +       done < <(tr -d '\t\n ' < "$past_params_file" | tr ';' '\n' | grep=
 -o '(.*)' | tr -d '()')


Maybe

  grep -o '(.*)' | tr -d '()'

can become a single process,

  sed 's/.*(\(.*\))/\1/'





> +
> +       local -A post_change_params
> +       while read -r mod_param_args; do
> +               param_name=3D"$(echo "$mod_param_args" | cut -d ',' -f 1)=
"
> +               param_params=3D"$(echo "$mod_param_args" | cut -d ',' -f =
2-)"
> +
> +               post_change_params[$param_name]=3D$param_params
> +       done < <(tr -d '\t\n ' < "$base_params_file" | tr ';' '\n' | grep=
 -o '(.*)' | tr -d '()')
> +
> +       # Flag any module param changes that:
> +       #  - Remove/rename a parameter
> +       #  - Change the arguments of the parameter
> +       local incompat_param_changes=3D0
> +       local pre
> +       local post
> +       for param_name in "${!pre_change_params[@]}"; do
> +               pre=3D"${pre_change_params[$param_name]}"
> +               if [ ! "${post_change_params[$param_name]+set}" ]; then
> +                       {
> +                               printf "Module parameter \"%s\" in %s rem=
oved!\n" "$param_name" "$file"
> +                               printf "  Original args: %s\n" "$pre"
> +                       } > "$error_log"
> +                       incompat_param_changes=3D$((incompat_param_change=
s + 1))
> +                       continue
> +               fi
> +
> +               post=3D"${post_change_params[$param_name]}"
> +               if [ "$pre" !=3D "$post" ]; then
> +                       {
> +                               printf "Module parameter \"%s\" in %s cha=
nged!\n" "$param_name" "$file"
> +                               printf "  Original args: %s\n" "$pre"
> +                               printf "       New args: %s\n" "$post"
> +                       } > "$error_log"
> +                       incompat_param_changes=3D$((incompat_param_change=
s + 1))
> +                       continue
> +               fi
> +       done
> +
> +       if [ "$incompat_param_changes" -gt 0 ]; then
> +               return 1
> +       fi
> +}
> +
> +run() {
> +       local base_ref=3D"$1"
> +       local past_ref=3D"$2"
> +       local abi_error_log=3D"$3"
> +
> +       diff_args=3D("$past_ref")
> +       if [ -n "$base_ref" ]; then
> +               diff_args+=3D("$base_ref")
> +       fi
> +
> +       local -a threads=3D()
> +       local passed=3D0
> +       local failed=3D0
> +       printf "Checking files between %s and %s for module parameter com=
patibility...\n" \
> +               "$past_ref" "$base_ref"
> +       while read -r modified_file; do
> +               if [ "${#threads[@]}" -ge "$MAX_THREADS" ]; then
> +                       wait "${threads[0]}" && ret=3D"$?" || ret=3D"$?"
> +                       if [ "$ret" -eq 0 ]; then
> +                               passed=3D$((passed + 1))
> +                       elif [ "$ret" -eq 1 ]; then
> +                               failed=3D$((failed + 1))
> +                       fi
> +                       threads=3D("${threads[@]:1}")
> +               fi
> +
> +               file_module_params_unmodified "$modified_file" "$base_ref=
" "$past_ref" &
> +               threads+=3D("$!")
> +       done < <(git diff --diff-filter=3DMCD --name-only "${diff_args[@]=
}" -- '*.c' '*.h')
> +
> +       for t in "${threads[@]}"; do
> +               wait "$t" && ret=3D"$?" || ret=3D"$?"
> +               if [ "$ret" -eq 0 ]; then
> +                       passed=3D$((passed + 1))
> +               elif [ "$ret" -eq 1 ]; then
> +                       failed=3D$((failed + 1))
> +               fi
> +       done
> +
> +       total=3D$((passed + failed))
> +       if [ "$total" -eq 0 ]; then
> +               printf "No files with module parameters modified between =
%s and %s\n" \
> +                       "$past_ref" "${base_ref:-dirty tree}"
> +               exit 0
> +       fi
> +
> +       if [ -n "$abi_error_log" ]; then
> +               printf 'Generated by "%s %s" from git ref %s\n\n' \
> +                       "$0" "$*" "$(git rev-parse HEAD)" > "$abi_error_l=
og"
> +       fi
> +
> +       while read -r error_file; do
> +               {
> +                       cat "$error_file"
> +                       printf "\n\n"
> +               } | tee -a "${abi_error_log:-/dev/null}" >&2
> +       done < <(find "$TMP_DIR" -type f -name '*.error')
> +
> +       if [ "$failed" -gt 0 ]; then
> +               eprintf "error - %d/%d files with modules parameters appe=
ar _not_ to be backwards compatible\n" \
> +                       "$failed" "$total"
> +               if [ -n "$abi_error_log" ]; then
> +                       eprintf "Failure summary saved to %s\n" "$abi_err=
or_log"
> +               fi
> +       else
> +               printf "All %d files with module_parameters checked appea=
r to be backwards compatible\n" \
> +                       "$total" "$ARCH"
> +       fi
> +
> +       exit "$failed"
> +}
> +
> +# Make sure the git refs we have make sense
> +check_refs() {
> +       if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
> +               eprintf "error - this script requires the kernel tree to =
be initialized with Git\n"
> +               return 1
> +       fi
> +
> +       if ! git rev-parse --verify "$past_ref" > /dev/null 2>&1; then
> +               printf 'error - invalid git reference "%s"\n' "$past_ref"
> +               return 1
> +       fi
> +
> +       if [ -n "$base_ref" ]; then
> +               if ! git merge-base --is-ancestor "$past_ref" "$base_ref"=
 > /dev/null 2>&1; then
> +                       printf 'error - "%s" is not an ancestor of base r=
ef "%s"\n' "$past_ref" "$base_ref"
> +                       return 1
> +               fi
> +               if [ "$(git rev-parse "$base_ref")" =3D "$(git rev-parse =
"$past_ref")" ]; then
> +                       printf 'error - "%s" and "%s" are the same refere=
nce\n' "$past_ref" "$base_ref"
> +                       return 1
> +               fi
> +       fi
> +}
> +
> +main() {
> +       MAX_THREADS=3D$(nproc)
> +       quiet=3D"false"
> +       local base_ref=3D""
> +       while getopts "hb:p:j:l:q" opt; do
> +               case $opt in
> +               h)
> +                       print_usage
> +                       exit "$SUCCESS"
> +                       ;;
> +               b)
> +                       base_ref=3D"$OPTARG"
> +                       ;;
> +               p)
> +                       past_ref=3D"$OPTARG"
> +                       ;;
> +               j)
> +                       MAX_THREADS=3D"$OPTARG"
> +                       ;;
> +               l)
> +                       abi_error_log=3D"$OPTARG"
> +                       ;;
> +               q)
> +                       quiet=3D"true"
> +                       ;;
> +               *)
> +                       exit "$FAIL_PREREQ"
> +               esac
> +       done
> +
> +       if [ "$quiet" =3D "true" ]; then
> +               exec > /dev/null 2>&1
> +       fi
> +
> +       if [ -z "$KERNEL_SRC" ]; then
> +               KERNEL_SRC=3D"$(realpath "$(dirname "$0")"/..)"
> +       fi
> +
> +       cd "$KERNEL_SRC"
> +
> +       if [ -z "$base_ref" ] && ! tree_is_dirty; then
> +               base_ref=3DHEAD
> +       fi
> +
> +       if [ -z "$past_ref" ]; then
> +               if [ -n "$base_ref" ]; then
> +                       past_ref=3D"${base_ref}^1"
> +               else
> +                       past_ref=3DHEAD
> +               fi
> +       fi
> +
> +       if ! check_refs; then
> +               exit "$FAIL_PREREQ"
> +       fi
> +
> +       TMP_DIR=3D$(mktemp -d)
> +       readonly TMP_DIR
> +       trap 'rm -rf "$TMP_DIR"' EXIT
> +
> +       run "$base_ref" "$past_ref" "$abi_error_log"
> +}
> +
> +main "$@"
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
